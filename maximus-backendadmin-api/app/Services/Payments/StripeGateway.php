<?php

namespace App\Services\Payments;

use App\Contracts\PaymentGatewayInterface;
use Stripe\Stripe;
use Stripe\PaymentIntent;
use Stripe\Refund;
use Stripe\Customer;
use Stripe\Webhook;
use Stripe\Exception\ApiErrorException;
use Stripe\Exception\SignatureVerificationException;
use Exception;

class StripeGateway implements PaymentGatewayInterface
{
    protected array $config = [];
    protected bool $initialized = false;

    public function getIdentifier(): string { return 'stripe'; }
    public function getName(): string { return 'Stripe'; }

    public function initialize(array $config): void
    {
        $this->config = $config;
        if (!empty($config['secret_key'])) {
            Stripe::setApiKey($config['secret_key']);
            $this->initialized = true;
        }
    }

    public function isConfigured(): bool
    {
        return $this->initialized && !empty($this->config['secret_key']) && !empty($this->config['publishable_key']);
    }

    public function isTestMode(): bool { return $this->config['test_mode'] ?? false; }
    public function getPublishableKey(): ?string { return $this->config['publishable_key'] ?? null; }

    public function createPayment(float $amount, string $currency = 'usd', array $options = []): array
    {
        try {
            $params = [
                'amount' => (int) round($amount * 100),
                'currency' => strtolower($currency),
                'automatic_payment_methods' => ['enabled' => true],
            ];
            if (!empty($options['metadata'])) $params['metadata'] = $options['metadata'];
            if (!empty($options['customer_id'])) $params['customer'] = $options['customer_id'];
            if (!empty($options['description'])) $params['description'] = $options['description'];
            if (!empty($options['receipt_email'])) $params['receipt_email'] = $options['receipt_email'];

            $paymentIntent = PaymentIntent::create($params);
            return [
                'success' => true, 'id' => $paymentIntent->id, 'client_secret' => $paymentIntent->client_secret,
                'status' => $this->mapStatus($paymentIntent->status), 'amount' => $amount, 'currency' => $currency,
                'gateway' => $this->getIdentifier(), 'raw' => $paymentIntent->toArray(),
            ];
        } catch (ApiErrorException $e) {
            return ['success' => false, 'error' => $e->getMessage(), 'code' => $e->getStripeCode(), 'gateway' => $this->getIdentifier()];
        }
    }

    public function retrievePayment(string $paymentId): array
    {
        try {
            $pi = PaymentIntent::retrieve($paymentId);
            return ['success' => true, 'id' => $pi->id, 'status' => $this->mapStatus($pi->status), 'amount' => $pi->amount / 100, 'currency' => $pi->currency, 'gateway' => $this->getIdentifier(), 'raw' => $pi->toArray()];
        } catch (ApiErrorException $e) {
            return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()];
        }
    }

    public function confirmPayment(string $paymentId, array $options = []): array
    {
        try {
            $pi = PaymentIntent::retrieve($paymentId);
            $params = !empty($options['payment_method']) ? ['payment_method' => $options['payment_method']] : [];
            $pi = $pi->confirm($params);
            return ['success' => true, 'id' => $pi->id, 'status' => $this->mapStatus($pi->status), 'gateway' => $this->getIdentifier(), 'raw' => $pi->toArray()];
        } catch (ApiErrorException $e) {
            return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()];
        }
    }

    public function cancelPayment(string $paymentId): array
    {
        try {
            $pi = PaymentIntent::retrieve($paymentId)->cancel();
            return ['success' => true, 'id' => $pi->id, 'status' => $this->mapStatus($pi->status), 'gateway' => $this->getIdentifier()];
        } catch (ApiErrorException $e) {
            return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()];
        }
    }

    public function refundPayment(string $paymentId, ?float $amount = null, ?string $reason = null): array
    {
        try {
            $params = ['payment_intent' => $paymentId];
            if ($amount !== null) $params['amount'] = (int) round($amount * 100);
            if ($reason !== null) $params['reason'] = $reason;
            $refund = Refund::create($params);
            return ['success' => true, 'id' => $refund->id, 'payment_id' => $paymentId, 'amount' => $refund->amount / 100, 'status' => $refund->status, 'gateway' => $this->getIdentifier()];
        } catch (ApiErrorException $e) {
            return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()];
        }
    }

    public function createCustomer(array $customerData): array
    {
        try {
            $params = array_filter(['email' => $customerData['email'] ?? null, 'name' => $customerData['name'] ?? null, 'phone' => $customerData['phone'] ?? null]);
            $customer = Customer::create($params);
            return ['success' => true, 'id' => $customer->id, 'email' => $customer->email, 'gateway' => $this->getIdentifier()];
        } catch (ApiErrorException $e) {
            return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()];
        }
    }

    public function getSupportedMethods(): array
    {
        $methods = ['card', 'apple_pay', 'google_pay'];
        if ($this->config['ach_enabled'] ?? false) $methods[] = 'us_bank_account';
        return $methods;
    }

    public function verifyWebhook(string $payload, string $signature): array
    {
        try {
            $secret = $this->config['webhook_secret'] ?? '';
            if (empty($secret)) throw new Exception('Webhook secret not configured');
            $event = Webhook::constructEvent($payload, $signature, $secret);
            return ['success' => true, 'type' => $event->type, 'data' => $event->data->object->toArray(), 'gateway' => $this->getIdentifier()];
        } catch (Exception $e) {
            return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()];
        }
    }

    public function mapStatus(string $gatewayStatus): string
    {
        return match ($gatewayStatus) {
            'requires_payment_method', 'requires_confirmation', 'requires_action' => 'pending',
            'processing' => 'processing', 'succeeded' => 'succeeded', 'canceled' => 'canceled',
            'requires_capture' => 'authorized', default => 'failed',
        };
    }

    public function getFrontendConfig(): array
    {
        return ['gateway' => $this->getIdentifier(), 'publishable_key' => $this->getPublishableKey(), 'supported_methods' => $this->getSupportedMethods(), 'test_mode' => $this->isTestMode()];
    }
}
