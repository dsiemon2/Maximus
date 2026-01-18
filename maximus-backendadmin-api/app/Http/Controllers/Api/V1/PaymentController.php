<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Services\Payments\PaymentManager;

class PaymentController extends Controller
{
    protected PaymentManager $paymentManager;

    public function __construct(PaymentManager $paymentManager) { $this->paymentManager = $paymentManager; }

    public function getGateways(): JsonResponse
    {
        if (!$this->paymentManager->hasEnabledGateway()) return response()->json(['success' => false, 'message' => 'No payment gateways configured'], 400);
        return response()->json(['success' => true, 'gateways' => $this->paymentManager->getFrontendConfigs(), 'enabled' => $this->paymentManager->getEnabledGateways(), 'supported_methods' => $this->paymentManager->getAllSupportedMethods()]);
    }

    public function createPayment(Request $request): JsonResponse
    {
        $request->validate(['amount' => 'required|numeric|min:0.01', 'currency' => 'string|size:3', 'gateway' => 'string|nullable']);
        $amount = $request->input('amount');
        $currency = $request->input('currency', 'usd');
        $gateway = $request->input('gateway');

        $options = array_filter([
            'order_id' => $request->input('order_id'),
            'receipt_email' => $request->input('customer_email'),
            'description' => $request->input('description'),
            'metadata' => $request->input('metadata'),
            'payment_method_nonce' => $request->input('payment_method_nonce'),
            'source_id' => $request->input('source_id'),
            'opaque_data' => $request->input('opaque_data'),
        ]);

        $result = $gateway ? $this->paymentManager->createPaymentWith($gateway, $amount, $currency, $options) : $this->paymentManager->createPayment($amount, $currency, $options);
        return response()->json($result, $result['success'] ? 200 : 400);
    }

    public function getPayment(Request $request, string $paymentId): JsonResponse
    {
        $result = $this->paymentManager->retrievePayment($paymentId, $request->query('gateway'));
        return response()->json($result, $result['success'] ? 200 : 404);
    }

    public function confirmPayment(Request $request, string $paymentId): JsonResponse
    {
        $options = array_filter(['payment_method' => $request->input('payment_method')]);
        $result = $this->paymentManager->confirmPayment($paymentId, $options, $request->input('gateway'));
        return response()->json($result, $result['success'] ? 200 : 400);
    }

    public function cancelPayment(Request $request, string $paymentId): JsonResponse
    {
        $result = $this->paymentManager->cancelPayment($paymentId, $request->input('gateway'));
        return response()->json($result, $result['success'] ? 200 : 400);
    }

    public function refundPayment(Request $request, string $paymentId): JsonResponse
    {
        $request->validate(['amount' => 'numeric|min:0.01|nullable', 'reason' => 'string|nullable']);
        $result = $this->paymentManager->refundPayment($paymentId, $request->input('amount'), $request->input('reason'), $request->input('gateway'));
        return response()->json($result, $result['success'] ? 200 : 400);
    }

    public function webhook(Request $request, string $gateway): JsonResponse
    {
        $payload = $request->getContent();
        $signature = $request->header('Stripe-Signature') ?? $request->header('X-Square-Signature') ?? $request->header('X-Anet-Signature') ?? $request->header('Bt-Signature') ?? '';
        $result = $this->paymentManager->verifyWebhook($payload, $signature, $gateway);
        if (!$result['success']) return response()->json($result, 400);
        \Log::info("Payment webhook: {$gateway}", ['type' => $result['type'] ?? '', 'data' => $result['data'] ?? []]);
        return response()->json(['success' => true, 'message' => 'Webhook processed']);
    }
}
