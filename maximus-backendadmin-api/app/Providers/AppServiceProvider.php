<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use App\Services\Payments\PaymentManager;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->singleton(PaymentManager::class, fn($app) => new PaymentManager());
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
