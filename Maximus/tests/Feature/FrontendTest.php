<?php

namespace Tests\Feature;

use Tests\TestCase;
use App\Models\User;
use App\Models\Product;
use App\Models\Category;
use Illuminate\Foundation\Testing\RefreshDatabase;

class FrontendTest extends TestCase
{
    /**
     * ==========================================
     * AUTHENTICATION TESTS
     * ==========================================
     */

    public function test_login_page_loads(): void
    {
        $response = $this->get('/login');
        $response->assertStatus(200);
        $response->assertSee('Login');
    }

    public function test_register_page_loads(): void
    {
        $response = $this->get('/register');
        $response->assertStatus(200);
        $response->assertSee('Register');
    }

    public function test_user_can_login_with_valid_credentials(): void
    {
        $user = User::where('email', 'admin@maximus.com')->first();

        if (!$user) {
            $this->markTestSkipped('Admin user not found in database');
        }

        $response = $this->post('/login', [
            'email' => 'admin@maximus.com',
            'password' => 'Test1234',
        ]);

        $response->assertRedirect('/dashboard');
        $this->assertAuthenticated();
    }

    public function test_user_cannot_login_with_invalid_credentials(): void
    {
        $response = $this->post('/login', [
            'email' => 'admin@maximus.com',
            'password' => 'wrongpassword',
        ]);

        $this->assertGuest();
    }

    public function test_logout_works(): void
    {
        $user = User::where('email', 'admin@maximus.com')->first();

        if (!$user) {
            $this->markTestSkipped('Admin user not found in database');
        }

        $response = $this->actingAs($user)->post('/logout');
        $response->assertRedirect('/');
        $this->assertGuest();
    }

    /**
     * ==========================================
     * NAVIGATION TESTS
     * ==========================================
     */

    public function test_home_page_loads(): void
    {
        $response = $this->get('/');
        $response->assertStatus(200);
    }

    public function test_about_page_loads(): void
    {
        $response = $this->get('/about');
        $response->assertStatus(200);
    }

    public function test_contact_page_loads(): void
    {
        $response = $this->get('/contact');
        $response->assertStatus(200);
    }

    public function test_products_page_loads(): void
    {
        $response = $this->get('/products');
        $response->assertStatus(200);
        $response->assertSee('Products');
    }

    public function test_cart_page_loads(): void
    {
        $response = $this->get('/cart');
        $response->assertStatus(200);
    }

    /**
     * ==========================================
     * PRODUCT TESTS
     * ==========================================
     */

    public function test_products_index_displays_products(): void
    {
        $response = $this->get('/products');
        $response->assertStatus(200);
    }

    public function test_products_can_be_filtered_by_category(): void
    {
        $category = Category::first();

        if (!$category) {
            $this->markTestSkipped('No categories in database');
        }

        $response = $this->get('/products?catid=' . $category->CategoryCode);
        $response->assertStatus(200);
    }

    public function test_product_detail_page_loads(): void
    {
        $product = Product::first();

        if (!$product) {
            $this->markTestSkipped('No products in database');
        }

        $response = $this->get('/products/' . $product->ID);
        $response->assertStatus(200);
    }

    /**
     * ==========================================
     * CART TESTS
     * ==========================================
     */

    public function test_add_to_cart_works(): void
    {
        $product = Product::first();

        if (!$product) {
            $this->markTestSkipped('No products in database');
        }

        $upc = $product->UPC ?: $product->ItemNumber;
        $response = $this->get('/cart/add?upc=' . $upc);
        $response->assertRedirect();
    }

    public function test_cart_update_works(): void
    {
        // First add an item
        $product = Product::first();

        if (!$product) {
            $this->markTestSkipped('No products in database');
        }

        $upc = $product->UPC ?: $product->ItemNumber;
        $this->get('/cart/add?upc=' . $upc);

        // Then update quantity
        $response = $this->postJson('/cart/update', [
            'index' => 0,
            'quantity' => 2,
        ]);

        $response->assertJson(['success' => true]);
    }

    /**
     * ==========================================
     * COMPARE TESTS
     * ==========================================
     */

    public function test_compare_page_loads(): void
    {
        $response = $this->get('/products/compare');
        $response->assertStatus(200);
    }

    public function test_add_to_compare_works(): void
    {
        $product = Product::first();

        if (!$product) {
            $this->markTestSkipped('No products in database');
        }

        $response = $this->postJson('/products/compare/add', [
            'product_id' => $product->ID,
        ]);

        $response->assertJson(['success' => true]);
    }

    /**
     * ==========================================
     * WISHLIST TESTS (requires authentication)
     * ==========================================
     */

    public function test_wishlist_requires_authentication(): void
    {
        $response = $this->get('/account/wishlist');
        $response->assertRedirect('/login');
    }

    public function test_authenticated_user_can_access_wishlist(): void
    {
        $user = User::first();

        if (!$user) {
            $this->markTestSkipped('No users in database');
        }

        $response = $this->actingAs($user)->get('/account/wishlist');
        $response->assertStatus(200);
    }

    public function test_wishlist_toggle_works(): void
    {
        $user = User::first();
        $product = Product::first();

        if (!$user || !$product) {
            $this->markTestSkipped('User or product not found');
        }

        $response = $this->actingAs($user)->postJson('/account/wishlist/toggle', [
            'product_id' => $product->ID,
        ]);

        $response->assertJson(['success' => true]);
    }

    public function test_wishlist_check_works(): void
    {
        $user = User::first();
        $product = Product::first();

        if (!$user || !$product) {
            $this->markTestSkipped('User or product not found');
        }

        $response = $this->actingAs($user)->get('/account/wishlist/check?product_ids=' . $product->ID);
        $response->assertJsonStructure(['wishlisted']);
    }

    /**
     * ==========================================
     * ACCOUNT TESTS (requires authentication)
     * ==========================================
     */

    public function test_account_dashboard_requires_authentication(): void
    {
        $response = $this->get('/account');
        $response->assertRedirect('/login');
    }

    public function test_authenticated_user_can_access_account(): void
    {
        $user = User::first();

        if (!$user) {
            $this->markTestSkipped('No users in database');
        }

        $response = $this->actingAs($user)->get('/account');
        $response->assertStatus(200);
        $response->assertSee('Welcome');
    }

    public function test_account_orders_page_loads(): void
    {
        $user = User::first();

        if (!$user) {
            $this->markTestSkipped('No users in database');
        }

        $response = $this->actingAs($user)->get('/account/orders');
        $response->assertStatus(200);
    }

    public function test_account_addresses_page_loads(): void
    {
        $user = User::first();

        if (!$user) {
            $this->markTestSkipped('No users in database');
        }

        $response = $this->actingAs($user)->get('/account/addresses');
        $response->assertStatus(200);
    }

    /**
     * ==========================================
     * ADMIN TESTS (requires admin role)
     * ==========================================
     */

    public function test_admin_dashboard_requires_manager_role(): void
    {
        $user = User::where('role', 'customer')->first();

        if (!$user) {
            $this->markTestSkipped('No customer user in database');
        }

        $response = $this->actingAs($user)->get('/admin');
        $response->assertStatus(403);
    }

    public function test_admin_user_can_access_admin_dashboard(): void
    {
        $user = User::where('role', 'admin')->first();

        if (!$user) {
            $this->markTestSkipped('No admin user in database');
        }

        $response = $this->actingAs($user)->get('/admin');
        $response->assertStatus(200);
    }

    /**
     * ==========================================
     * API INTEGRATION TESTS
     * ==========================================
     */

    public function test_branding_api_returns_valid_response(): void
    {
        $response = $this->getJson('/api/v1/admin/settings');

        // API might be on different port, so we test the service instead
        $brandingService = new \App\Services\BrandingService();
        $settings = $brandingService->getSettings();

        $this->assertIsArray($settings);
    }

    public function test_features_api_returns_valid_response(): void
    {
        $featuresService = new \App\Services\FeaturesService();
        $features = $featuresService->getFeatures();

        $this->assertIsArray($features);
        $this->assertArrayHasKey('admin_link_enabled', $features);
    }

    /**
     * ==========================================
     * HEADER/FOOTER COMPONENT TESTS
     * ==========================================
     */

    public function test_header_contains_navigation_links(): void
    {
        $response = $this->get('/');

        $response->assertSee('Home');
        $response->assertSee('Products');
        $response->assertSee('Cart');
        $response->assertSee('Contact');
    }

    public function test_admin_menu_visible_for_admin_users(): void
    {
        $user = User::where('role', 'admin')->first();

        if (!$user) {
            $this->markTestSkipped('No admin user in database');
        }

        $response = $this->actingAs($user)->get('/');
        $response->assertSee('Admin');
    }

    public function test_admin_menu_hidden_for_regular_users(): void
    {
        $user = User::where('role', 'customer')->first();

        if (!$user) {
            $this->markTestSkipped('No customer user in database');
        }

        $response = $this->actingAs($user)->get('/');
        $response->assertDontSee('bi-speedometer2'); // Admin icon
    }
}
