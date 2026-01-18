@extends('layouts.app')

@section('title', $categoryName . ' - Products')

@push('styles')
<style>
    .product-card {
        background: white;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        transition: transform 0.3s, box-shadow 0.3s;
        overflow: hidden;
        height: 100%;
        position: relative;
    }
    .product-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }
    .product-card img {
        height: 200px;
        object-fit: contain;
        width: 100%;
        background: #f8f9fa;
    }
    .product-card-body {
        padding: 15px;
    }
    .product-card-title {
        font-size: 1rem;
        min-height: 48px;
    }
    .product-price {
        font-size: 1.25rem;
        font-weight: bold;
        color: var(--prt-brown);
    }
    /* Wishlist Heart Button */
    .wishlist-btn {
        position: absolute;
        top: 10px;
        right: 10px;
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: white;
        border: none;
        box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s;
        z-index: 10;
    }
    .wishlist-btn:hover {
        transform: scale(1.1);
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }
    .wishlist-btn .bi-heart {
        color: #6c757d;
        font-size: 1.1rem;
    }
    .wishlist-btn .bi-heart-fill {
        color: #dc3545;
        font-size: 1.1rem;
    }
    .wishlist-btn.active .bi-heart {
        display: none;
    }
    .wishlist-btn:not(.active) .bi-heart-fill {
        display: none;
    }
    /* Compare Widget */
    .compare-widget {
        position: fixed;
        bottom: 20px;
        right: 20px;
        z-index: 1040;
    }
    .compare-widget .badge {
        position: absolute;
        top: -5px;
        right: -5px;
    }
</style>
@endpush

@section('content')
<div class="container mt-4">
    {{-- Breadcrumb --}}
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="{{ route('home') }}">Home</a></li>
            <li class="breadcrumb-item"><a href="{{ route('products.index') }}">Products</a></li>
            @if($filters['catid'])
                <li class="breadcrumb-item active">{{ $categoryName }}</li>
            @else
                <li class="breadcrumb-item active">All Products</li>
            @endif
        </ol>
    </nav>
</div>

<div class="container my-4">
    <div class="row">
        {{-- Sidebar --}}
        <div class="col-lg-3 mb-4">
            <div class="sticky-sidebar">
                {{-- Categories --}}
                <div class="sidebar-categories">
                    <h5><i class="bi bi-funnel"></i> Filter by Category</h5>
                    <a href="{{ route('products.index') }}"
                       class="category-link {{ !$filters['catid'] ? 'active' : '' }}">
                        <i class="bi bi-grid-3x3-gap"></i> All Products
                        <span class="badge bg-secondary float-end">{{ $products->total() }}</span>
                    </a>
                    @foreach($categories as $cat)
                        <a href="{{ route('products.index', ['catid' => $cat->CategoryCode]) }}"
                           class="category-link {{ $filters['catid'] == $cat->CategoryCode ? 'active' : '' }}">
                            <i class="bi bi-box-seam"></i> {{ $cat->Category }}
                            <span class="badge bg-secondary float-end">{{ $cat->products_count }}</span>
                        </a>
                    @endforeach
                </div>

                {{-- Search --}}
                <div class="sidebar-categories">
                    <h5><i class="bi bi-search"></i> Search Products</h5>
                    <form method="GET" action="{{ route('products.index') }}">
                        @if($filters['catid'])
                            <input type="hidden" name="catid" value="{{ $filters['catid'] }}">
                        @endif
                        <div class="input-group">
                            <input type="text" name="search" class="form-control"
                                   placeholder="Search..." value="{{ $filters['search'] }}">
                            <button class="btn btn-primary" type="submit" data-bs-toggle="tooltip" title="Search for products">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </form>
                </div>

                {{-- Advanced Filters --}}
                <div class="sidebar-categories">
                    <h5><i class="bi bi-sliders"></i> Advanced Filters</h5>
                    <form method="GET" action="{{ route('products.index') }}">
                        @if($filters['catid'])
                            <input type="hidden" name="catid" value="{{ $filters['catid'] }}">
                        @endif
                        @if($filters['search'])
                            <input type="hidden" name="search" value="{{ $filters['search'] }}">
                        @endif

                        <div class="mb-3">
                            <label class="form-label small fw-bold">Price Range</label>
                            <div class="row g-2">
                                <div class="col-6">
                                    <input type="number" name="min_price" class="form-control form-control-sm"
                                           placeholder="Min" step="0.01" min="0" value="{{ $filters['min_price'] }}">
                                </div>
                                <div class="col-6">
                                    <input type="number" name="max_price" class="form-control form-control-sm"
                                           placeholder="Max" step="0.01" min="0" value="{{ $filters['max_price'] }}">
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold">Size</label>
                            <select name="size" class="form-select form-select-sm">
                                <option value="">All Sizes</option>
                                @foreach($sizes as $size)
                                    <option value="{{ $size }}" {{ $filters['size'] == $size ? 'selected' : '' }}>
                                        {{ $size }}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold">Sort By</label>
                            <select name="sort" class="form-select form-select-sm">
                                <option value="" {{ $filters['sort'] == '' ? 'selected' : '' }}>Default Order</option>
                                <option value="newest" {{ $filters['sort'] == 'newest' ? 'selected' : '' }}>Newest First</option>
                                <option value="price_low" {{ $filters['sort'] == 'price_low' ? 'selected' : '' }}>Price: Low to High</option>
                                <option value="price_high" {{ $filters['sort'] == 'price_high' ? 'selected' : '' }}>Price: High to Low</option>
                                <option value="name_asc" {{ $filters['sort'] == 'name_asc' ? 'selected' : '' }}>Name: A to Z</option>
                                <option value="name_desc" {{ $filters['sort'] == 'name_desc' ? 'selected' : '' }}>Name: Z to A</option>
                            </select>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-sm" data-bs-toggle="tooltip" title="Apply selected filters to products">
                                <i class="bi bi-funnel-fill"></i> Apply Filters
                            </button>
                            <a href="{{ route('products.index', $filters['catid'] ? ['catid' => $filters['catid']] : []) }}"
                               class="btn btn-outline-secondary btn-sm" data-bs-toggle="tooltip" title="Reset all filters to default">
                                <i class="bi bi-x-circle"></i> Clear Filters
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        {{-- Products Grid --}}
        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="mb-2" style="color: var(--prt-brown);">{{ $categoryName }}</h2>
                    <p class="text-muted">
                        Showing {{ $products->firstItem() ?? 0 }} - {{ $products->lastItem() ?? 0 }}
                        of {{ $products->total() }} products
                        @if($filters['search'])
                            for "{{ $filters['search'] }}"
                        @endif
                    </p>
                </div>
            </div>

            @if($products->count() > 0)
                <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-4">
                    @foreach($products as $product)
                        <div class="col">
                            <div class="product-card">
                                {{-- Wishlist Heart Button --}}
                                <button class="wishlist-btn"
                                        data-product-id="{{ $product->ID }}"
                                        onclick="toggleWishlist(event, {{ $product->ID }}, this)"
                                        title="Add to Wishlist">
                                    <i class="bi bi-heart"></i>
                                    <i class="bi bi-heart-fill"></i>
                                </button>

                                <a href="{{ route('products.show', $product->ID) }}">
                                    <img src="{{ $product->primaryImage }}"
                                         alt="{{ $product->ShortDescription }}"
                                         onerror="this.src='{{ asset('assets/images/no-image.svg') }}'">
                                </a>

                                <div class="product-card-body">
                                    <h5 class="product-card-title">
                                        <a href="{{ route('products.show', $product->ID) }}"
                                           class="text-decoration-none" style="color: var(--prt-brown);">
                                            {{ $product->ShortDescription ?: 'Product #' . $product->ItemNumber }}
                                        </a>
                                    </h5>

                                    @if($product->LngDescription)
                                        <p class="text-muted small mb-3" style="min-height: 3rem;">
                                            {{ Str::limit($product->LngDescription, 100) }}
                                        </p>
                                    @else
                                        <div style="min-height: 3rem;"></div>
                                    @endif

                                    <p class="text-muted small mb-2">
                                        @if($product->ItemNumber)
                                            <i class="bi bi-upc"></i> {{ $product->ItemNumber }}
                                        @endif
                                    </p>

                                    <div class="product-price mb-2">
                                        @if($product->UnitPrice)
                                            ${{ number_format($product->UnitPrice, 2) }}
                                        @endif
                                    </div>

                                    @if($product->track_inventory)
                                        <div class="mb-2">
                                            @php $status = $product->stockStatus; @endphp
                                            <span class="badge bg-{{ $status == 'In Stock' ? 'success' : ($status == 'Low Stock' ? 'warning' : 'danger') }}">
                                                <i class="bi bi-box-seam"></i> {{ $status }}
                                            </span>
                                        </div>
                                    @endif

                                    <div class="d-grid gap-2">
                                        <button onclick="showQuickView({{ $product->ID }})"
                                                class="btn btn-outline-primary btn-sm" data-bs-toggle="tooltip" title="Preview product details in a popup">
                                            <i class="bi bi-eye-fill"></i> Quick View
                                        </button>
                                        <button onclick="addToCart('{{ $product->UPC ?: $product->ItemNumber }}', {{ $product->ID }})"
                                                class="btn btn-primary" data-bs-toggle="tooltip" title="Add this product to your shopping cart">
                                            <i class="bi bi-cart-plus"></i> Add to Cart
                                        </button>
                                        <button onclick="addToCompareList({{ $product->ID }}, this)"
                                                class="btn btn-outline-info btn-sm" data-bs-toggle="tooltip" title="Add to compare list to compare with other products">
                                            <i class="bi bi-arrow-left-right"></i> Compare
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    @endforeach
                </div>

                {{-- Pagination --}}
                @if($products->hasPages())
                    <nav aria-label="Product pagination">
                        <ul class="pagination justify-content-center">
                            <li class="page-item {{ $products->onFirstPage() ? 'disabled' : '' }}">
                                <a class="page-link" href="{{ $products->previousPageUrl() }}" data-bs-toggle="tooltip" title="Go to previous page">
                                    <i class="bi bi-chevron-left"></i> Previous
                                </a>
                            </li>

                            @foreach($products->getUrlRange(max(1, $products->currentPage() - 2), min($products->lastPage(), $products->currentPage() + 2)) as $page => $url)
                                <li class="page-item {{ $page == $products->currentPage() ? 'active' : '' }}">
                                    <a class="page-link" href="{{ $url }}">{{ $page }}</a>
                                </li>
                            @endforeach

                            <li class="page-item {{ !$products->hasMorePages() ? 'disabled' : '' }}">
                                <a class="page-link" href="{{ $products->nextPageUrl() }}" data-bs-toggle="tooltip" title="Go to next page">
                                    Next <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                @endif
            @else
                <div class="alert alert-info text-center py-5">
                    <i class="bi bi-search display-1 d-block mb-3" style="color: var(--prt-brown);"></i>
                    <h3>No Products Found</h3>
                    <p class="mb-3">
                        @if($filters['search'])
                            No products match your search for "{{ $filters['search'] }}".
                        @else
                            No products available in this category.
                        @endif
                    </p>
                    <a href="{{ route('products.index') }}" class="btn btn-primary" data-bs-toggle="tooltip" title="Browse all available products">
                        <i class="bi bi-grid"></i> View All Products
                    </a>
                </div>
            @endif
        </div>
    </div>
</div>

<!-- Quick View Modal -->
<div class="modal fade" id="quickViewModal" tabindex="-1" aria-labelledby="quickViewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="quickViewModalLabel">
                    <i class="bi bi-eye-fill"></i> Quick View
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="quickViewBody">
                <!-- Content loaded dynamically -->
            </div>
        </div>
    </div>
</div>

{{-- Compare Widget --}}
<div class="compare-widget" id="compareWidget" style="display: none;">
    <a href="{{ route('products.compare') }}" class="btn btn-info btn-lg shadow position-relative" data-bs-toggle="tooltip" title="View product comparison">
        <i class="bi bi-arrow-left-right"></i>
        <span class="badge bg-danger" id="compareCount">0</span>
    </a>
</div>
@endsection

@push('scripts')
<script>
// Compare count from session
let compareCount = {{ count(session('compare_products', [])) }};

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Bootstrap tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Update compare widget visibility
    updateCompareWidget(compareCount);

    // Check wishlist status for logged in users
    @auth
    checkWishlistStatus();
    @endauth
});

// ============================================
// WISHLIST FUNCTIONALITY
// ============================================
async function toggleWishlist(event, productId, button) {
    event.preventDefault();
    event.stopPropagation();

    // Check if user is logged in
    if (!IS_AUTHENTICATED) {
        showToast('Please log in to add items to your wishlist', 'warning');
        setTimeout(() => {
            window.location.href = '{{ route("login") }}';
        }, 1500);
        return;
    }

    try {
        const response = await fetch('{{ route("account.wishlist.toggle") }}', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': CSRF_TOKEN
            },
            body: JSON.stringify({ product_id: productId })
        });

        const data = await response.json();

        if (data.success) {
            // Toggle the active class on the button
            if (data.in_wishlist) {
                button.classList.add('active');
                button.title = 'Remove from Wishlist';
            } else {
                button.classList.remove('active');
                button.title = 'Add to Wishlist';
            }
            showToast(data.message, 'success');
        } else {
            showToast(data.message || 'Failed to update wishlist', 'danger');
        }
    } catch (error) {
        console.error('Error toggling wishlist:', error);
        showToast('Failed to update wishlist. Please try again.', 'danger');
    }
}

// Check wishlist status for all products on page load
@auth
async function checkWishlistStatus() {
    const wishlistButtons = document.querySelectorAll('.wishlist-btn');
    const productIds = Array.from(wishlistButtons).map(btn => btn.dataset.productId);

    if (productIds.length === 0) return;

    try {
        const response = await fetch('{{ route("account.wishlist.check") }}?product_ids=' + productIds.join(','));
        const data = await response.json();

        if (data.wishlisted && data.wishlisted.length > 0) {
            data.wishlisted.forEach(productId => {
                const btn = document.querySelector(`[data-product-id="${productId}"]`);
                if (btn) {
                    btn.classList.add('active');
                    btn.title = 'Remove from Wishlist';
                }
            });
        }
    } catch (error) {
        console.error('Error checking wishlist status:', error);
    }
}
@endauth

// ============================================
// CART FUNCTIONALITY
// ============================================
function addToCart(upc, productId) {
    window.location.href = '{{ url("cart/add") }}?upc=' + encodeURIComponent(upc);
}

// ============================================
// COMPARE FUNCTIONALITY
// ============================================
function addToCompareList(productId, button) {
    fetch('{{ route("products.compare.add") }}', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': CSRF_TOKEN
        },
        body: JSON.stringify({ product_id: productId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showToast(data.message + ' <a href="{{ route("products.compare") }}" class="alert-link">View comparison</a>', 'success');
            updateCompareWidget(data.count);
            // Update button state
            button.classList.add('btn-info');
            button.classList.remove('btn-outline-info');
            button.innerHTML = '<i class="bi bi-check-lg"></i> Added';
        } else {
            showToast(data.message || 'Failed to add to compare', 'warning');
        }
    })
    .catch(error => {
        console.error('Error adding to compare:', error);
        showToast('Failed to add to compare. Please try again.', 'danger');
    });
}

function updateCompareWidget(count) {
    const widget = document.getElementById('compareWidget');
    const countBadge = document.getElementById('compareCount');

    if (widget && countBadge) {
        countBadge.textContent = count;
        widget.style.display = count > 0 ? 'block' : 'none';
    }
}

// ============================================
// QUICK VIEW MODAL
// ============================================
async function showQuickView(productId) {
    const modal = new bootstrap.Modal(document.getElementById('quickViewModal'));
    const modalBody = document.getElementById('quickViewBody');

    // Show loading state
    modalBody.innerHTML = '<div class="text-center p-5"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>';
    modal.show();

    try {
        const response = await fetch(`{{ url('products') }}/${productId}`);
        const html = await response.text();

        // Parse the HTML to extract product info
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html');

        // Extract product details
        const title = doc.querySelector('h1')?.textContent || 'Product';
        const image = doc.querySelector('#mainImage')?.src || '{{ asset("assets/images/no-image.svg") }}';
        const priceEl = doc.querySelector('.product-price');
        const price = priceEl ? priceEl.textContent.trim() : '';
        const description = doc.querySelector('.lead')?.textContent || '';

        // Extract item number and UPC from the table
        let itemNumber = '';
        let upc = '';
        const tableRows = doc.querySelectorAll('table tr');
        tableRows.forEach(row => {
            const label = row.querySelector('td:first-child')?.textContent || '';
            const value = row.querySelector('td:last-child')?.textContent || '';
            if (label.includes('Item Number')) {
                itemNumber = value.trim();
            }
            if (label.includes('UPC')) {
                upc = value.trim();
            }
        });

        // Use UPC if available, otherwise use ItemNumber
        const cartIdentifier = upc || itemNumber;

        // Build modal content
        modalBody.innerHTML = `
            <div class="row">
                <div class="col-md-6 mb-3">
                    <img src="${image}" class="img-fluid rounded" alt="${title}" onerror="this.src='{{ asset("assets/images/no-image.svg") }}'">
                </div>
                <div class="col-md-6">
                    <h3 style="color: var(--prt-brown);">${title}</h3>
                    <p class="text-muted"><i class="bi bi-upc"></i> ${itemNumber}</p>
                    <h2 class="text-primary mb-3">${price}</h2>
                    <p>${description}</p>
                    <div class="mb-3">
                        <label class="form-label"><strong>Quantity:</strong></label>
                        <div class="input-group" style="max-width: 150px;">
                            <button class="btn btn-outline-secondary" type="button" onclick="adjustQuickViewQty(-1)">
                                <i class="bi bi-dash"></i>
                            </button>
                            <input type="number" class="form-control text-center" id="quickViewQuantity" value="1" min="1" max="99">
                            <button class="btn btn-outline-secondary" type="button" onclick="adjustQuickViewQty(1)">
                                <i class="bi bi-plus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="d-grid gap-2 mt-4">
                        <a href="{{ url('products') }}/${productId}" class="btn btn-outline-primary">
                            <i class="bi bi-eye"></i> View Full Details
                        </a>
                        <button onclick="addToCartFromQuickView('${cartIdentifier}')" class="btn btn-primary">
                            <i class="bi bi-cart-plus"></i> Add to Cart
                        </button>
                        <button onclick="addToCompareFromQuickView(${productId})" class="btn btn-outline-info">
                            <i class="bi bi-arrow-left-right"></i> Add to Compare
                        </button>
                    </div>
                </div>
            </div>
        `;
    } catch (error) {
        console.error('Error loading quick view:', error);
        modalBody.innerHTML = '<div class="alert alert-danger">Failed to load product details. Please try again.</div>';
    }
}

function adjustQuickViewQty(change) {
    const qtyInput = document.getElementById('quickViewQuantity');
    if (qtyInput) {
        const currentQty = parseInt(qtyInput.value) || 1;
        const newQty = Math.max(1, Math.min(99, currentQty + change));
        qtyInput.value = newQty;
    }
}

function addToCartFromQuickView(upc) {
    let url = '{{ url("cart/add") }}?upc=' + encodeURIComponent(upc);

    // Get quantity
    const qtyInput = document.getElementById('quickViewQuantity');
    const quantity = qtyInput ? parseInt(qtyInput.value) || 1 : 1;
    url += '&qty=' + quantity;

    window.location.href = url;
}

function addToCompareFromQuickView(productId) {
    fetch('{{ route("products.compare.add") }}', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': CSRF_TOKEN
        },
        body: JSON.stringify({ product_id: productId })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showToast(data.message, 'success');
            updateCompareWidget(data.count);
        } else {
            showToast(data.message || 'Failed to add to compare', 'warning');
        }
    });
}
</script>
@endpush
