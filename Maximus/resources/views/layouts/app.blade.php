@php
    use App\Services\BrandingService;
    $layoutBrandingService = new BrandingService();
@endphp
<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', config('app.name', 'Maximus Pet Store'))</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="{{ asset('assets/css/custom.css') }}">

    <!-- Dynamic Theme CSS from Admin API -->
    {!! $layoutBrandingService->getThemeCSS() !!}
    {!! $layoutBrandingService->getNavbarCSS() !!}

    @stack('styles')
</head>
<body>
    <!-- Header -->
    @include('components.header')

    <!-- Flash Messages -->
    @if(session('success'))
        <div class="container mt-3">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                {{ session('success') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
    @endif

    @if(session('error'))
        <div class="container mt-3">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                {{ session('error') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
    @endif

    <!-- Main Content -->
    <main>
        @yield('content')
    </main>

    <!-- Footer -->
    @include('components.footer')

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Global JS Variables -->
    <script>
        const CSRF_TOKEN = '{{ csrf_token() }}';
        const BASE_URL = '{{ url('/') }}';
        const IS_AUTHENTICATED = {{ auth()->check() ? 'true' : 'false' }};
        const USER_ID = {{ auth()->id() ?? 'null' }};

        /**
         * Show toast notification
         * @param {string} message - Message to display
         * @param {string} type - Toast type (success, warning, danger, info)
         */
        function showToast(message, type = 'info') {
            // Handle legacy parameter order (type, message)
            if (['success', 'warning', 'danger', 'info', 'error'].includes(message) && typeof type === 'string' && type.length > 10) {
                const temp = message;
                message = type;
                type = temp;
            }

            // Map 'error' to 'danger' for Bootstrap
            if (type === 'error') type = 'danger';

            // Check if toast container exists, if not create it
            let toastContainer = document.getElementById('toastContainer');
            if (!toastContainer) {
                toastContainer = document.createElement('div');
                toastContainer.id = 'toastContainer';
                toastContainer.style.cssText = 'position: fixed; top: 80px; right: 20px; z-index: 9999;';
                document.body.appendChild(toastContainer);
            }

            // Create toast element
            const toast = document.createElement('div');
            toast.className = `alert alert-${type} alert-dismissible fade show shadow-lg`;
            toast.style.cssText = 'min-width: 300px; max-width: 500px;';
            toast.setAttribute('role', 'alert');

            // Icon based on type
            const icons = {
                success: 'bi-check-circle-fill',
                warning: 'bi-exclamation-triangle-fill',
                danger: 'bi-x-circle-fill',
                info: 'bi-info-circle-fill'
            };
            const icon = icons[type] || icons.info;

            toast.innerHTML = `
                <i class="bi ${icon} me-2"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            `;

            toastContainer.appendChild(toast);

            // Auto-dismiss after 4 seconds
            setTimeout(() => {
                toast.classList.remove('show');
                setTimeout(() => toast.remove(), 150);
            }, 4000);
        }
    </script>

    <!-- Custom JS -->
    <script src="{{ asset('assets/js/main.js') }}"></script>

    @stack('scripts')
</body>
</html>
