<?php

namespace App\Services\Payments;

use App\Contracts\PaymentGatewayInterface;
use net\authorize\api\contract\v1 as AnetAPI;
use net\authorize\api\controller as AnetController;
use Exception;

class AuthorizeNetGateway implements PaymentGatewayInterface
{
    protected array $config = [];
    protected bool $initialized = false;
    protected ?AnetAPI\MerchantAuthenticationType $merchantAuth = null;

    public function getIdentifier(): string { return 'authorizenet'; }
    public function getName(): string { return 'Authorize.net'; }

    public function initialize(array $config): void
    {
        $this->config = $config;
        if (!empty($config['login_id']) && !empty($config['transaction_key'])) {
            $this->merchantAuth = new AnetAPI\MerchantAuthenticationType();
            $this->merchantAuth->setName($config['login_id']);
            $this->merchantAuth->setTransactionKey($config['transaction_key']);
            $this->initialized = true;
        }
    }

    public function isConfigured(): bool { return $this->initialized && !empty($this->config['login_id']) && !empty($this->config['transaction_key']); }
    public function isTestMode(): bool { return $this->config['sandbox'] ?? false; }
    public function getPublishableKey(): ?string { return $this->config['login_id'] ?? null; }
    protected function getEndpoint(): string { return $this->isTestMode() ? \net\authorize\api\constants\ANetEnvironment::SANDBOX : \net\authorize\api\constants\ANetEnvironment::PRODUCTION; }

    public function createPayment(float $amount, string $currency = 'usd', array $options = []): array
    {
        if (!$this->merchantAuth) return ['success' => false, 'error' => 'Gateway not initialized', 'gateway' => $this->getIdentifier()];
        try {
            $txRequest = new AnetAPI\TransactionRequestType();
            $txRequest->setTransactionType('authCaptureTransaction');
            $txRequest->setAmount(number_format($amount, 2, '.', ''));

            if (!empty($options['opaque_data'])) {
                $opaqueData = new AnetAPI\OpaqueDataType();
                $opaqueData->setDataDescriptor($options['opaque_data']['data_descriptor']);
                $opaqueData->setDataValue($options['opaque_data']['data_value']);
                $paymentType = new AnetAPI\PaymentType(); $paymentType->setOpaqueData($opaqueData);
                $txRequest->setPayment($paymentType);
            } elseif (!empty($options['card_number'])) {
                $creditCard = new AnetAPI\CreditCardType();
                $creditCard->setCardNumber($options['card_number']);
                $creditCard->setExpirationDate($options['expiration_date']);
                if (!empty($options['card_code'])) $creditCard->setCardCode($options['card_code']);
                $paymentType = new AnetAPI\PaymentType(); $paymentType->setCreditCard($creditCard);
                $txRequest->setPayment($paymentType);
            }

            if (!empty($options['order_id'])) {
                $order = new AnetAPI\OrderType(); $order->setInvoiceNumber($options['order_id']);
                if (!empty($options['description'])) $order->setDescription(substr($options['description'], 0, 255));
                $txRequest->setOrder($order);
            }

            $request = new AnetAPI\CreateTransactionRequest();
            $request->setMerchantAuthentication($this->merchantAuth);
            $request->setRefId($options['ref_id'] ?? uniqid('anet_'));
            $request->setTransactionRequest($txRequest);

            $controller = new AnetController\CreateTransactionController($request);
            $response = $controller->executeWithApiResponse($this->getEndpoint());

            if ($response !== null && $response->getMessages()->getResultCode() === 'Ok') {
                $txResponse = $response->getTransactionResponse();
                if ($txResponse !== null && $txResponse->getMessages() !== null) {
                    return ['success' => true, 'id' => $txResponse->getTransId(), 'auth_code' => $txResponse->getAuthCode(), 'status' => $this->mapStatus($txResponse->getResponseCode()), 'amount' => $amount, 'currency' => $currency, 'gateway' => $this->getIdentifier(), 'raw' => ['transaction_id' => $txResponse->getTransId(), 'auth_code' => $txResponse->getAuthCode()]];
                }
                if ($txResponse !== null && $txResponse->getErrors() !== null) return ['success' => false, 'error' => $txResponse->getErrors()[0]->getErrorText(), 'gateway' => $this->getIdentifier()];
            }
            $errorMessages = $response->getMessages()->getMessage();
            return ['success' => false, 'error' => $errorMessages[0]->getText() ?? 'Transaction failed', 'gateway' => $this->getIdentifier()];
        } catch (Exception $e) { return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()]; }
    }

    public function retrievePayment(string $paymentId): array
    {
        if (!$this->merchantAuth) return ['success' => false, 'error' => 'Gateway not initialized', 'gateway' => $this->getIdentifier()];
        try {
            $request = new AnetAPI\GetTransactionDetailsRequest();
            $request->setMerchantAuthentication($this->merchantAuth); $request->setTransId($paymentId);
            $controller = new AnetController\GetTransactionDetailsController($request);
            $response = $controller->executeWithApiResponse($this->getEndpoint());
            if ($response !== null && $response->getMessages()->getResultCode() === 'Ok') {
                $tx = $response->getTransaction();
                return ['success' => true, 'id' => $tx->getTransId(), 'status' => $this->mapStatus($tx->getTransactionStatus()), 'amount' => (float) $tx->getSettleAmount(), 'currency' => 'usd', 'gateway' => $this->getIdentifier(), 'raw' => ['transaction_id' => $tx->getTransId(), 'status' => $tx->getTransactionStatus()]];
            }
            return ['success' => false, 'error' => 'Transaction not found', 'gateway' => $this->getIdentifier()];
        } catch (Exception $e) { return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()]; }
    }

    public function confirmPayment(string $paymentId, array $options = []): array { return $this->capturePayment($paymentId, $options['amount'] ?? null); }

    public function capturePayment(string $paymentId, ?float $amount = null): array
    {
        if (!$this->merchantAuth) return ['success' => false, 'error' => 'Gateway not initialized', 'gateway' => $this->getIdentifier()];
        try {
            $txRequest = new AnetAPI\TransactionRequestType();
            $txRequest->setTransactionType('priorAuthCaptureTransaction'); $txRequest->setRefTransId($paymentId);
            if ($amount !== null) $txRequest->setAmount(number_format($amount, 2, '.', ''));
            $request = new AnetAPI\CreateTransactionRequest();
            $request->setMerchantAuthentication($this->merchantAuth); $request->setTransactionRequest($txRequest);
            $controller = new AnetController\CreateTransactionController($request);
            $response = $controller->executeWithApiResponse($this->getEndpoint());
            if ($response !== null && $response->getMessages()->getResultCode() === 'Ok') return ['success' => true, 'id' => $response->getTransactionResponse()->getTransId(), 'status' => 'succeeded', 'gateway' => $this->getIdentifier()];
            return ['success' => false, 'error' => 'Capture failed', 'gateway' => $this->getIdentifier()];
        } catch (Exception $e) { return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()]; }
    }

    public function cancelPayment(string $paymentId): array
    {
        if (!$this->merchantAuth) return ['success' => false, 'error' => 'Gateway not initialized', 'gateway' => $this->getIdentifier()];
        try {
            $txRequest = new AnetAPI\TransactionRequestType();
            $txRequest->setTransactionType('voidTransaction'); $txRequest->setRefTransId($paymentId);
            $request = new AnetAPI\CreateTransactionRequest();
            $request->setMerchantAuthentication($this->merchantAuth); $request->setTransactionRequest($txRequest);
            $controller = new AnetController\CreateTransactionController($request);
            $response = $controller->executeWithApiResponse($this->getEndpoint());
            if ($response !== null && $response->getMessages()->getResultCode() === 'Ok') return ['success' => true, 'id' => $paymentId, 'status' => 'canceled', 'gateway' => $this->getIdentifier()];
            return ['success' => false, 'error' => 'Void failed', 'gateway' => $this->getIdentifier()];
        } catch (Exception $e) { return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()]; }
    }

    public function refundPayment(string $paymentId, ?float $amount = null, ?string $reason = null): array
    {
        if (!$this->merchantAuth) return ['success' => false, 'error' => 'Gateway not initialized', 'gateway' => $this->getIdentifier()];
        try {
            $details = $this->retrievePayment($paymentId);
            if (!$details['success']) return $details;
            $txRequest = new AnetAPI\TransactionRequestType();
            $txRequest->setTransactionType('refundTransaction'); $txRequest->setRefTransId($paymentId);
            $txRequest->setAmount($amount !== null ? number_format($amount, 2, '.', '') : $details['amount']);
            $creditCard = new AnetAPI\CreditCardType(); $creditCard->setCardNumber('XXXX'); $creditCard->setExpirationDate('XXXX');
            $paymentType = new AnetAPI\PaymentType(); $paymentType->setCreditCard($creditCard);
            $txRequest->setPayment($paymentType);
            $request = new AnetAPI\CreateTransactionRequest();
            $request->setMerchantAuthentication($this->merchantAuth); $request->setTransactionRequest($txRequest);
            $controller = new AnetController\CreateTransactionController($request);
            $response = $controller->executeWithApiResponse($this->getEndpoint());
            if ($response !== null && $response->getMessages()->getResultCode() === 'Ok') return ['success' => true, 'id' => $response->getTransactionResponse()->getTransId(), 'payment_id' => $paymentId, 'amount' => $amount ?? $details['amount'], 'status' => 'refunded', 'gateway' => $this->getIdentifier()];
            return ['success' => false, 'error' => 'Refund failed', 'gateway' => $this->getIdentifier()];
        } catch (Exception $e) { return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()]; }
    }

    public function createCustomer(array $customerData): array
    {
        if (!$this->merchantAuth) return ['success' => false, 'error' => 'Gateway not initialized', 'gateway' => $this->getIdentifier()];
        try {
            $customerProfile = new AnetAPI\CustomerProfileType();
            if (!empty($customerData['email'])) $customerProfile->setEmail($customerData['email']);
            if (!empty($customerData['id'])) $customerProfile->setMerchantCustomerId($customerData['id']);
            $request = new AnetAPI\CreateCustomerProfileRequest();
            $request->setMerchantAuthentication($this->merchantAuth); $request->setProfile($customerProfile);
            $controller = new AnetController\CreateCustomerProfileController($request);
            $response = $controller->executeWithApiResponse($this->getEndpoint());
            if ($response !== null && $response->getMessages()->getResultCode() === 'Ok') return ['success' => true, 'id' => $response->getCustomerProfileId(), 'email' => $customerData['email'] ?? null, 'gateway' => $this->getIdentifier()];
            return ['success' => false, 'error' => 'Failed to create customer profile', 'gateway' => $this->getIdentifier()];
        } catch (Exception $e) { return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()]; }
    }

    public function getSupportedMethods(): array { return ['card', 'echeck']; }

    public function verifyWebhook(string $payload, string $signature): array
    {
        try {
            $data = json_decode($payload, true);
            return ['success' => true, 'type' => $data['eventType'] ?? '', 'data' => $data['payload'] ?? [], 'gateway' => $this->getIdentifier()];
        } catch (Exception $e) { return ['success' => false, 'error' => $e->getMessage(), 'gateway' => $this->getIdentifier()]; }
    }

    public function mapStatus(string $gatewayStatus): string
    {
        return match ($gatewayStatus) {
            '1', 'settledSuccessfully' => 'succeeded', '2', 'declined' => 'failed', '3', 'communicationError' => 'failed',
            '4', 'FDSPendingReview', 'authorizedPendingCapture' => 'pending', 'voided' => 'canceled', default => 'pending',
        };
    }

    public function getFrontendConfig(): array
    {
        return ['gateway' => $this->getIdentifier(), 'login_id' => $this->getPublishableKey(), 'supported_methods' => $this->getSupportedMethods(), 'test_mode' => $this->isTestMode(), 'accept_js_url' => $this->isTestMode() ? 'https://jstest.authorize.net/v1/Accept.js' : 'https://js.authorize.net/v1/Accept.js'];
    }
}
