<?php

namespace App\Contracts;

/**
 * Interface for Payment Gateway implementations
 *
 * All payment gateways (Stripe, Braintree, PayPal, Square, Authorize.net)
 * must implement this interface to ensure consistent behavior.
 */
interface PaymentGatewayInterface
{
    public function getIdentifier(): string;
    public function getName(): string;
    public function initialize(array $config): void;
    public function isConfigured(): bool;
    public function isTestMode(): bool;
    public function getPublishableKey(): ?string;
    public function createPayment(float $amount, string $currency = 'usd', array $options = []): array;
    public function retrievePayment(string $paymentId): array;
    public function confirmPayment(string $paymentId, array $options = []): array;
    public function cancelPayment(string $paymentId): array;
    public function refundPayment(string $paymentId, ?float $amount = null, ?string $reason = null): array;
    public function createCustomer(array $customerData): array;
    public function getSupportedMethods(): array;
    public function verifyWebhook(string $payload, string $signature): array;
    public function mapStatus(string $gatewayStatus): string;
    public function getFrontendConfig(): array;
}
