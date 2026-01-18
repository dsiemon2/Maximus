<?php

namespace App\Services\Payments;

use App\Contracts\PaymentGatewayInterface;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Exception;

class PaymentManager
{
    protected array $gateways = [];
    protected array $configurations = [];
    protected ?string $activeGateway = null;

    protected array $gatewayClasses = [
        'stripe' => StripeGateway::class,
        'braintree' => BraintreeGateway::class,
        'paypal' => PayPalGateway::class,
        'square' => SquareGateway::class,
        'authorizenet' => AuthorizeNetGateway::class,
    ];

    public function __construct() { $this->loadConfigurations(); }

    protected function loadConfigurations(): void
    {
        try {
            $this->configurations = Cache::remember('payment_gateway_configs', 300, fn() => $this->fetchConfigurationsFromDatabase());
            foreach ($this->configurations as $identifier => $config) {
                if ($config['enabled'] ?? false) {
                    $this->initializeGateway($identifier, $config);
                    if ($this->activeGateway === null) $this->activeGateway = $identifier;
                }
            }
        } catch (Exception $e) { report($e); }
    }

    protected function fetchConfigurationsFromDatabase(): array
    {
        $configs = [];
        try {
            $settings = DB::table('settings')->where('setting_group', 'features')->pluck('setting_value', 'setting_key')->toArray();

            if (!empty($settings['stripe_enabled']) && $this->isTruthy($settings['stripe_enabled'])) {
                $configs['stripe'] = ['enabled' => true, 'publishable_key' => $settings['stripe_publishable_key'] ?? '', 'secret_key' => $settings['stripe_secret_key'] ?? '', 'webhook_secret' => $settings['stripe_webhook_secret'] ?? '', 'test_mode' => $this->isTruthy($settings['stripe_test_mode'] ?? false), 'ach_enabled' => $this->isTruthy($settings['stripe_ach_enabled'] ?? false)];
            }
            if (!empty($settings['braintree_enabled']) && $this->isTruthy($settings['braintree_enabled'])) {
                $configs['braintree'] = ['enabled' => true, 'merchant_id' => $settings['braintree_merchant_id'] ?? '', 'public_key' => $settings['braintree_public_key'] ?? '', 'private_key' => $settings['braintree_private_key'] ?? '', 'sandbox' => $this->isTruthy($settings['braintree_sandbox'] ?? false)];
            }
            if (!empty($settings['paypal_enabled']) && $this->isTruthy($settings['paypal_enabled'])) {
                $configs['paypal'] = ['enabled' => true, 'client_id' => $settings['paypal_client_id'] ?? '', 'client_secret' => $settings['paypal_client_secret'] ?? '', 'sandbox' => $this->isTruthy($settings['paypal_sandbox'] ?? false)];
            }
            if (!empty($settings['square_enabled']) && $this->isTruthy($settings['square_enabled'])) {
                $configs['square'] = ['enabled' => true, 'application_id' => $settings['square_application_id'] ?? '', 'access_token' => $settings['square_access_token'] ?? '', 'location_id' => $settings['square_location_id'] ?? '', 'sandbox' => $this->isTruthy($settings['square_sandbox'] ?? false)];
            }
            if (!empty($settings['authorizenet_enabled']) && $this->isTruthy($settings['authorizenet_enabled'])) {
                $configs['authorizenet'] = ['enabled' => true, 'login_id' => $settings['authorizenet_login_id'] ?? '', 'transaction_key' => $settings['authorizenet_transaction_key'] ?? '', 'signature_key' => $settings['authorizenet_signature_key'] ?? '', 'sandbox' => $this->isTruthy($settings['authorizenet_sandbox'] ?? false)];
            }
        } catch (Exception $e) { report($e); }
        return $configs;
    }

    protected function isTruthy($value): bool { return $value === true || $value === '1' || $value === 'true' || $value === 1; }

    protected function initializeGateway(string $identifier, array $config): void
    {
        if (!isset($this->gatewayClasses[$identifier])) return;
        $gateway = new ($this->gatewayClasses[$identifier])();
        $gateway->initialize($config);
        $this->gateways[$identifier] = $gateway;
    }

    public function gateway(string $identifier): ?PaymentGatewayInterface { return $this->gateways[$identifier] ?? null; }
    public function getActiveGateway(): ?PaymentGatewayInterface { return $this->activeGateway ? ($this->gateways[$this->activeGateway] ?? null) : null; }
    public function setActiveGateway(string $identifier): self { if (isset($this->gateways[$identifier])) $this->activeGateway = $identifier; return $this; }
    public function getEnabledGateways(): array { return array_keys($this->gateways); }
    public function getAvailableGateways(): array { return array_keys($this->gatewayClasses); }
    public function hasEnabledGateway(): bool { return !empty($this->gateways); }
    public function isGatewayEnabled(string $identifier): bool { return isset($this->gateways[$identifier]); }

    public function clearCache(): void
    {
        Cache::forget('payment_gateway_configs');
        $this->gateways = []; $this->configurations = []; $this->activeGateway = null;
        $this->loadConfigurations();
    }

    public function getFrontendConfigs(): array
    {
        $configs = [];
        foreach ($this->gateways as $identifier => $gateway) $configs[$identifier] = $gateway->getFrontendConfig();
        return $configs;
    }

    public function createPayment(float $amount, string $currency = 'usd', array $options = []): array
    {
        $gateway = $this->getActiveGateway();
        if (!$gateway) return ['success' => false, 'error' => 'No payment gateway configured'];
        return $gateway->createPayment($amount, $currency, $options);
    }

    public function createPaymentWith(string $identifier, float $amount, string $currency = 'usd', array $options = []): array
    {
        $gateway = $this->gateway($identifier);
        if (!$gateway) return ['success' => false, 'error' => "Gateway '{$identifier}' not configured"];
        return $gateway->createPayment($amount, $currency, $options);
    }

    public function retrievePayment(string $paymentId, ?string $gatewayIdentifier = null): array
    {
        if ($gatewayIdentifier && ($g = $this->gateway($gatewayIdentifier))) return $g->retrievePayment($paymentId);
        if ($g = $this->getActiveGateway()) { $r = $g->retrievePayment($paymentId); if ($r['success']) return $r; }
        foreach ($this->gateways as $g) { $r = $g->retrievePayment($paymentId); if ($r['success']) return $r; }
        return ['success' => false, 'error' => 'Payment not found'];
    }

    public function confirmPayment(string $paymentId, array $options = [], ?string $gatewayIdentifier = null): array
    {
        $gateway = $gatewayIdentifier ? $this->gateway($gatewayIdentifier) : $this->getActiveGateway();
        if (!$gateway) return ['success' => false, 'error' => 'No payment gateway configured'];
        return $gateway->confirmPayment($paymentId, $options);
    }

    public function cancelPayment(string $paymentId, ?string $gatewayIdentifier = null): array
    {
        $gateway = $gatewayIdentifier ? $this->gateway($gatewayIdentifier) : $this->getActiveGateway();
        if (!$gateway) return ['success' => false, 'error' => 'No payment gateway configured'];
        return $gateway->cancelPayment($paymentId);
    }

    public function refundPayment(string $paymentId, ?float $amount = null, ?string $reason = null, ?string $gatewayIdentifier = null): array
    {
        $gateway = $gatewayIdentifier ? $this->gateway($gatewayIdentifier) : $this->getActiveGateway();
        if (!$gateway) return ['success' => false, 'error' => 'No payment gateway configured'];
        return $gateway->refundPayment($paymentId, $amount, $reason);
    }

    public function createCustomer(array $customerData, ?string $gatewayIdentifier = null): array
    {
        $gateway = $gatewayIdentifier ? $this->gateway($gatewayIdentifier) : $this->getActiveGateway();
        if (!$gateway) return ['success' => false, 'error' => 'No payment gateway configured'];
        return $gateway->createCustomer($customerData);
    }

    public function verifyWebhook(string $payload, string $signature, string $gatewayIdentifier): array
    {
        $gateway = $this->gateway($gatewayIdentifier);
        if (!$gateway) return ['success' => false, 'error' => "Gateway '{$gatewayIdentifier}' not configured"];
        return $gateway->verifyWebhook($payload, $signature);
    }

    public function getAllSupportedMethods(): array
    {
        $methods = [];
        foreach ($this->gateways as $identifier => $gateway) $methods[$identifier] = $gateway->getSupportedMethods();
        return $methods;
    }
}
