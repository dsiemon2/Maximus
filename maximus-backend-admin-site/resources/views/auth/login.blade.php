<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - {{ config('app.name') }}</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        :root {
            --theme-primary: #2E86AB;
            --theme-secondary: #4CAF50;
        }

        body {
            background: linear-gradient(135deg, #2E86AB 0%, #1a5276 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            max-width: 420px;
            width: 100%;
        }

        .login-header {
            background: var(--theme-primary);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .login-header h3 {
            margin: 0;
            font-weight: 600;
        }

        .login-header p {
            margin: 10px 0 0;
            opacity: 0.9;
            font-size: 0.9rem;
        }

        .login-body {
            padding: 30px;
        }

        .form-control:focus {
            border-color: var(--theme-primary);
            box-shadow: 0 0 0 0.2rem rgba(46, 134, 171, 0.25);
        }

        .btn-login {
            background: var(--theme-primary);
            border-color: var(--theme-primary);
            padding: 12px;
            font-weight: 600;
        }

        .btn-login:hover {
            background: #1a5276;
            border-color: #1a5276;
        }

        .input-group-text {
            background: #f8f9fa;
        }

        .logo-icon {
            font-size: 3rem;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="login-header">
            <div class="logo-icon">
                <i class="bi bi-shield-lock"></i>
            </div>
            <h3>Admin Panel</h3>
            <p>{{ config('app.name') }}</p>
        </div>

        <div class="login-body">
            <!-- Success Messages -->
            @if(session('success'))
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle"></i> {{ session('success') }}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            @endif

            <!-- Error Messages -->
            @if($errors->any())
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle"></i>
                    @foreach($errors->all() as $error)
                        {{ $error }}
                    @endforeach
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            @endif

            <!-- Test Credentials Notice -->
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <strong><i class="bi bi-info-circle"></i> Test Account:</strong><br>
                Email: <code>admin@maximus.com</code><br>
                Password: <code>Test1234</code>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>

            <form method="POST" action="{{ route('login.submit') }}">
                @csrf

                <div class="mb-3">
                    <label for="email" class="form-label">Email Address</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                        <input type="email"
                               class="form-control"
                               id="email"
                               name="email"
                               value="{{ old('email', 'admin@maximus.com') }}"
                               placeholder="admin@example.com"
                               required
                               autofocus>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password"
                               class="form-control"
                               id="password"
                               name="password"
                               value="Test1234"
                               placeholder="Enter your password"
                               required>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-login w-100">
                    <i class="bi bi-box-arrow-in-right"></i> Sign In
                </button>
            </form>

            <div class="text-center mt-4">
                <a href="{{ env('STOREFRONT_URL', 'http://localhost:8400') }}" class="text-muted text-decoration-none">
                    <i class="bi bi-arrow-left"></i> Back to Store
                </a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
