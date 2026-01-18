<?php

namespace Tests\Feature;

use Tests\TestCase;
use Illuminate\Support\Facades\Http;

class ApiComparisonTest extends TestCase
{
    protected $apiBaseUrl;

    protected function setUp(): void
    {
        parent::setUp();
        $this->apiBaseUrl = 'http://localhost:8400/api/v1';
    }

    /**
     * ==========================================
     * API ENDPOINT AVAILABILITY TESTS
     * ==========================================
     */

    public function test_branding_endpoint_returns_success(): void
    {
        $response = Http::timeout(10)->get($this->apiBaseUrl . '/admin/settings');

        $this->assertTrue($response->successful(), 'Branding API failed: ' . $response->body());

        $data = $response->json();
        $this->assertTrue($data['success'] ?? false, 'API did not return success=true');
    }

    public function test_features_endpoint_returns_success(): void
    {
        $response = Http::timeout(10)->get($this->apiBaseUrl . '/admin/settings/features');

        $this->assertTrue($response->successful(), 'Features API failed: ' . $response->body());

        $data = $response->json();
        $this->assertTrue($data['success'] ?? false, 'API did not return success=true');
        $this->assertArrayHasKey('data', $data);
    }

    public function test_categories_endpoint_returns_success(): void
    {
        $response = Http::timeout(10)->get($this->apiBaseUrl . '/categories');

        $this->assertTrue($response->successful(), 'Categories API failed: ' . $response->body());
    }

    public function test_products_endpoint_returns_success(): void
    {
        $response = Http::timeout(10)->get($this->apiBaseUrl . '/products');

        $this->assertTrue($response->successful(), 'Products API failed: ' . $response->body());
    }

    public function test_featured_categories_endpoint_returns_success(): void
    {
        $response = Http::timeout(10)->get($this->apiBaseUrl . '/featured-categories');

        $this->assertTrue($response->successful(), 'Featured Categories API failed: ' . $response->body());
    }

    public function test_featured_products_endpoint_returns_success(): void
    {
        $response = Http::timeout(10)->get($this->apiBaseUrl . '/featured-products');

        $this->assertTrue($response->successful(), 'Featured Products API failed: ' . $response->body());
    }

    public function test_footer_endpoint_returns_success(): void
    {
        $response = Http::timeout(10)->get($this->apiBaseUrl . '/footer');

        $this->assertTrue($response->successful(), 'Footer API failed: ' . $response->body());
    }

    /**
     * ==========================================
     * FEATURE FLAGS VALIDATION
     * ==========================================
     */

    public function test_required_feature_flags_exist(): void
    {
        $response = Http::timeout(10)->get($this->apiBaseUrl . '/admin/settings/features');
        $data = $response->json();

        $requiredFeatures = [
            'admin_link_enabled',
            'wishlists_enabled',
            'faq_enabled',
            'blog_enabled',
            'events_enabled',
            'reviews_enabled',
            'loyalty_enabled',
            'gift_cards_enabled',
        ];

        foreach ($requiredFeatures as $feature) {
            $this->assertArrayHasKey($feature, $data['data'], "Missing feature flag: $feature");
        }
    }

    /**
     * ==========================================
     * BRANDING VALIDATION
     * ==========================================
     */

    public function test_branding_contains_required_fields(): void
    {
        $response = Http::timeout(10)->get($this->apiBaseUrl . '/admin/settings');
        $data = $response->json();

        // Check that branding data exists
        $this->assertTrue($data['success'] ?? false);
        $this->assertArrayHasKey('data', $data);
    }

    /**
     * ==========================================
     * DATA INTEGRITY TESTS
     * ==========================================
     */

    public function test_categories_have_required_fields(): void
    {
        $response = Http::timeout(10)->get($this->apiBaseUrl . '/categories');
        $data = $response->json();

        if (isset($data['data']) && count($data['data']) > 0) {
            $category = $data['data'][0];
            $this->assertArrayHasKey('CategoryCode', $category);
            $this->assertArrayHasKey('Category', $category);
        }
    }

    public function test_products_have_required_fields(): void
    {
        $response = Http::timeout(10)->get($this->apiBaseUrl . '/products');
        $data = $response->json();

        if (isset($data['data']) && count($data['data']) > 0) {
            $product = $data['data'][0];
            $this->assertArrayHasKey('ID', $product);
            $this->assertArrayHasKey('ShortDescription', $product);
            $this->assertArrayHasKey('UnitPrice', $product);
        }
    }
}
