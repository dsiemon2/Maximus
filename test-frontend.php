<?php
/**
 * Maximus Frontend Test Script
 *
 * This script tests the frontend functionality and compares with API responses.
 * Run from command line: php test-frontend.php
 */

$baseUrl = 'http://localhost:8400';
$apiUrl = 'http://localhost:8400/api/v1';

$results = [];
$passed = 0;
$failed = 0;

function test($name, $condition, $message = '') {
    global $results, $passed, $failed;

    if ($condition) {
        $passed++;
        $results[] = ['name' => $name, 'status' => 'PASS', 'message' => $message];
        echo "✓ PASS: $name\n";
    } else {
        $failed++;
        $results[] = ['name' => $name, 'status' => 'FAIL', 'message' => $message];
        echo "✗ FAIL: $name" . ($message ? " - $message" : "") . "\n";
    }
}

function httpGet($url, $timeout = 10) {
    $ch = curl_init();
    curl_setopt_array($ch, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => $timeout,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_SSL_VERIFYPEER => false,
    ]);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $error = curl_error($ch);
    curl_close($ch);

    return ['body' => $response, 'code' => $httpCode, 'error' => $error];
}

function httpPost($url, $data = [], $timeout = 10) {
    $ch = curl_init();
    curl_setopt_array($ch, [
        CURLOPT_URL => $url,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => $timeout,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($data),
        CURLOPT_HTTPHEADER => ['Content-Type: application/json', 'Accept: application/json'],
        CURLOPT_SSL_VERIFYPEER => false,
    ]);
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    return ['body' => $response, 'code' => $httpCode];
}

echo "\n";
echo "╔══════════════════════════════════════════════════════════════╗\n";
echo "║           MAXIMUS FRONTEND TEST SUITE                        ║\n";
echo "╚══════════════════════════════════════════════════════════════╝\n";
echo "\n";

// ==========================================
// SECTION 1: PAGE LOAD TESTS
// ==========================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
echo "SECTION 1: PAGE LOAD TESTS\n";
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";

$pages = [
    '/login' => 'Login Page',
    '/register' => 'Register Page',
    '/products' => 'Products Page',
    '/cart' => 'Cart Page',
    '/about' => 'About Page',
    '/contact' => 'Contact Page',
    '/compare' => 'Compare Page',
];

foreach ($pages as $path => $name) {
    $response = httpGet($baseUrl . $path);
    test(
        "$name loads ($path)",
        $response['code'] === 200,
        "HTTP {$response['code']}"
    );
}

// ==========================================
// SECTION 2: API ENDPOINT TESTS
// ==========================================
echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
echo "SECTION 2: API ENDPOINT TESTS\n";
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";

$apiEndpoints = [
    '/admin/settings' => 'Branding Settings API',
    '/admin/settings/features' => 'Features API',
    '/categories' => 'Categories API',
    '/products' => 'Products API',
    '/featured-categories' => 'Featured Categories API',
    '/featured-products' => 'Featured Products API',
    '/footer' => 'Footer API',
];

foreach ($apiEndpoints as $path => $name) {
    $response = httpGet($apiUrl . $path);
    $isSuccess = $response['code'] === 200;

    if ($isSuccess) {
        $data = json_decode($response['body'], true);
        $isSuccess = $isSuccess && (isset($data['success']) ? $data['success'] : true);
    }

    test(
        "$name ($path)",
        $isSuccess,
        "HTTP {$response['code']}"
    );
}

// ==========================================
// SECTION 3: FEATURE FLAGS VALIDATION
// ==========================================
echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
echo "SECTION 3: FEATURE FLAGS VALIDATION\n";
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";

$response = httpGet($apiUrl . '/admin/settings/features');
$features = json_decode($response['body'], true);

$requiredFeatures = [
    'admin_link_enabled' => 'Admin Link',
    'wishlists_enabled' => 'Wishlists',
    'faq_enabled' => 'FAQ',
    'blog_enabled' => 'Blog',
    'events_enabled' => 'Events',
    'reviews_enabled' => 'Reviews',
    'loyalty_enabled' => 'Loyalty',
    'gift_cards_enabled' => 'Gift Cards',
];

if (isset($features['data'])) {
    foreach ($requiredFeatures as $key => $name) {
        test(
            "Feature flag exists: $name",
            isset($features['data'][$key]),
            isset($features['data'][$key]) ? ($features['data'][$key] ? 'enabled' : 'disabled') : 'missing'
        );
    }
} else {
    test('Features API returns data', false, 'No data returned');
}

// ==========================================
// SECTION 4: CART FUNCTIONALITY
// ==========================================
echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
echo "SECTION 4: CART FUNCTIONALITY\n";
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";

// Get a product to test with
$productsResponse = httpGet($apiUrl . '/products');
$products = json_decode($productsResponse['body'], true);

if (isset($products['data']) && count($products['data']) > 0) {
    $testProduct = $products['data'][0];
    $upc = $testProduct['UPC'] ?? $testProduct['ItemNumber'] ?? null;

    if ($upc) {
        $addToCartResponse = httpGet($baseUrl . '/cart/add?upc=' . urlencode($upc));
        test(
            'Add to Cart redirects properly',
            in_array($addToCartResponse['code'], [200, 302]),
            "HTTP {$addToCartResponse['code']}"
        );
    } else {
        test('Add to Cart', false, 'No UPC found for test product');
    }
} else {
    test('Add to Cart', false, 'No products available to test');
}

// ==========================================
// SECTION 5: COMPARE FUNCTIONALITY
// ==========================================
echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
echo "SECTION 5: COMPARE FUNCTIONALITY\n";
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";

if (isset($products['data']) && count($products['data']) > 0) {
    $testProduct = $products['data'][0];
    $productId = $testProduct['ID'];

    $compareResponse = httpPost($baseUrl . '/compare/add', ['product_id' => $productId]);

    // HTTP 419 = CSRF token mismatch, which is expected for POST without session
    // This confirms the route exists and CSRF protection is working
    test(
        'Add to Compare route exists (CSRF protected)',
        in_array($compareResponse['code'], [200, 419]),
        "HTTP {$compareResponse['code']} - CSRF protection active"
    );
} else {
    test('Add to Compare', false, 'No products available to test');
}

// ==========================================
// SECTION 6: CONTENT VALIDATION
// ==========================================
echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
echo "SECTION 6: CONTENT VALIDATION\n";
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";

$homeResponse = httpGet($baseUrl . '/');
$homeContent = $homeResponse['body'];

$navElements = [
    'Home' => 'Home link',
    'Products' => 'Products link',
    'Cart' => 'Cart link',
    'Contact' => 'Contact link',
    'Account' => 'Account dropdown',
];

foreach ($navElements as $text => $name) {
    test(
        "Header contains $name",
        strpos($homeContent, $text) !== false
    );
}

$productsResponse = httpGet($baseUrl . '/products');
$productsContent = $productsResponse['body'];

$productPageElements = [
    'Quick View' => 'Quick View button',
    'Add to Cart' => 'Add to Cart button',
    'Compare' => 'Compare button',
];

foreach ($productPageElements as $text => $name) {
    test(
        "Products page has $name",
        strpos($productsContent, $text) !== false
    );
}

// ==========================================
// SECTION 7: PROTECTED ROUTES
// ==========================================
echo "\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";
echo "SECTION 7: PROTECTED ROUTES (should redirect to login)\n";
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n";

$protectedRoutes = [
    '/account' => 'Account Dashboard',
    '/account/orders' => 'Orders Page',
    '/account/wishlist' => 'Wishlist Page',
    '/account/addresses' => 'Addresses Page',
];

foreach ($protectedRoutes as $path => $name) {
    $response = httpGet($baseUrl . $path);
    // Should redirect (302) or show login page
    test(
        "$name requires authentication",
        $response['code'] === 302 || strpos($response['body'], 'login') !== false,
        "HTTP {$response['code']}"
    );
}

// ==========================================
// SUMMARY
// ==========================================
echo "\n";
echo "╔══════════════════════════════════════════════════════════════╗\n";
echo "║                      TEST SUMMARY                            ║\n";
echo "╠══════════════════════════════════════════════════════════════╣\n";
printf("║  Total Tests: %-45d ║\n", $passed + $failed);
printf("║  Passed:      %-45d ║\n", $passed);
printf("║  Failed:      %-45d ║\n", $failed);
echo "╠══════════════════════════════════════════════════════════════╣\n";

$percentage = ($passed + $failed) > 0 ? round(($passed / ($passed + $failed)) * 100, 1) : 0;
$status = $failed === 0 ? 'ALL TESTS PASSED!' : ($percentage >= 80 ? 'MOSTLY PASSING' : 'NEEDS ATTENTION');

printf("║  Pass Rate:   %-45s ║\n", "$percentage%");
printf("║  Status:      %-45s ║\n", $status);
echo "╚══════════════════════════════════════════════════════════════╝\n";

if ($failed > 0) {
    echo "\nFailed Tests:\n";
    foreach ($results as $result) {
        if ($result['status'] === 'FAIL') {
            echo "  - {$result['name']}" . ($result['message'] ? " ({$result['message']})" : "") . "\n";
        }
    }
}

echo "\n";
exit($failed > 0 ? 1 : 0);
