<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     * Creates all pet-specific tables for Maximus Pet Store
     * Note: Legacy schema uses UPC for products, CategoryCode for categories
     */
    public function up(): void
    {
        // ===========================================
        // Pet Types & Classification Tables
        // ===========================================

        // Pet Types (Dog, Cat, Bird, Fish, Small Pets, Reptiles)
        Schema::create('pet_types', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100);
            $table->string('slug', 100)->unique();
            $table->text('description')->nullable();
            $table->string('icon')->nullable();
            $table->string('image')->nullable();
            $table->integer('sort_order')->default(0);
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });

        // Pet Breeds (optional breed information)
        Schema::create('pet_breeds', function (Blueprint $table) {
            $table->id();
            $table->foreignId('pet_type_id')->constrained('pet_types')->onDelete('cascade');
            $table->string('name', 100);
            $table->string('slug', 100);
            $table->text('description')->nullable();
            $table->enum('size_category', ['small', 'medium', 'large', 'giant'])->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            $table->unique(['pet_type_id', 'slug']);
        });

        // Product to Pet Type relationship (uses UPC from legacy products table)
        Schema::create('product_pet_types', function (Blueprint $table) {
            $table->id();
            $table->string('product_upc', 50);
            $table->foreignId('pet_type_id')->constrained('pet_types')->onDelete('cascade');
            $table->boolean('is_primary')->default(false);
            $table->timestamps();

            $table->unique(['product_upc', 'pet_type_id']);
            $table->index('product_upc');
        });

        // Product Life Stages (Puppy/Kitten, Adult, Senior)
        Schema::create('product_life_stages', function (Blueprint $table) {
            $table->id();
            $table->string('product_upc', 50);
            $table->enum('life_stage', ['baby', 'young', 'adult', 'senior', 'all']);
            $table->timestamps();

            $table->unique(['product_upc', 'life_stage']);
            $table->index('product_upc');
        });

        // Product Size Suitability
        Schema::create('product_size_suitability', function (Blueprint $table) {
            $table->id();
            $table->string('product_upc', 50);
            $table->enum('size', ['small', 'medium', 'large', 'giant', 'all']);
            $table->timestamps();

            $table->unique(['product_upc', 'size']);
            $table->index('product_upc');
        });

        // ===========================================
        // Customer Pet Profiles
        // ===========================================

        // Customer Pets
        Schema::create('customer_pets', function (Blueprint $table) {
            $table->id();
            $table->integer('customer_id')->unsigned();
            $table->foreignId('pet_type_id')->constrained('pet_types');
            $table->foreignId('pet_breed_id')->nullable()->constrained('pet_breeds');
            $table->string('name', 100);
            $table->date('birth_date')->nullable();
            $table->enum('gender', ['male', 'female', 'unknown'])->default('unknown');
            $table->decimal('weight', 8, 2)->nullable();
            $table->enum('weight_unit', ['lbs', 'kg'])->default('lbs');
            $table->enum('size', ['small', 'medium', 'large', 'giant'])->nullable();
            $table->string('image')->nullable();
            $table->text('notes')->nullable();
            $table->text('dietary_restrictions')->nullable();
            $table->text('health_conditions')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            $table->index('customer_id');
        });

        // Pet Product Recommendations
        Schema::create('pet_product_recommendations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('customer_pet_id')->constrained('customer_pets')->onDelete('cascade');
            $table->string('product_upc', 50);
            $table->enum('recommendation_type', ['based_on_breed', 'based_on_age', 'based_on_size', 'based_on_purchase_history', 'manual']);
            $table->decimal('relevance_score', 5, 2)->default(0);
            $table->boolean('is_dismissed')->default(false);
            $table->timestamp('dismissed_at')->nullable();
            $table->timestamps();

            $table->unique(['customer_pet_id', 'product_upc']);
            $table->index('product_upc');
        });

        // ===========================================
        // Auto-Ship / Subscription Tables
        // ===========================================

        // Subscriptions (recurring order management)
        Schema::create('subscriptions', function (Blueprint $table) {
            $table->id();
            $table->integer('customer_id')->unsigned();
            $table->string('subscription_number', 50)->unique();
            $table->string('name', 100)->nullable();
            $table->enum('status', ['active', 'paused', 'cancelled', 'expired'])->default('active');
            $table->enum('frequency', ['weekly', 'biweekly', 'monthly', 'bimonthly', 'quarterly'])->default('monthly');
            $table->integer('frequency_days')->default(30);
            $table->date('next_order_date');
            $table->date('last_order_date')->nullable();
            $table->decimal('subtotal', 10, 2)->default(0);
            $table->decimal('discount_amount', 10, 2)->default(0);
            $table->decimal('discount_percentage', 5, 2)->default(0);
            $table->decimal('shipping_cost', 10, 2)->default(0);
            $table->decimal('tax_amount', 10, 2)->default(0);
            $table->decimal('total', 10, 2)->default(0);
            $table->unsignedBigInteger('shipping_address_id')->nullable();
            $table->unsignedBigInteger('billing_address_id')->nullable();
            $table->string('payment_method_id')->nullable();
            $table->integer('orders_placed')->default(0);
            $table->integer('skip_count')->default(0);
            $table->text('notes')->nullable();
            $table->timestamp('paused_at')->nullable();
            $table->timestamp('cancelled_at')->nullable();
            $table->string('cancellation_reason')->nullable();
            $table->timestamps();
            $table->softDeletes();

            $table->index('customer_id');
            $table->index('status');
            $table->index('next_order_date');
        });

        // Subscription Items
        Schema::create('subscription_items', function (Blueprint $table) {
            $table->id();
            $table->foreignId('subscription_id')->constrained('subscriptions')->onDelete('cascade');
            $table->string('product_upc', 50);
            $table->foreignId('customer_pet_id')->nullable()->constrained('customer_pets');
            $table->integer('quantity')->default(1);
            $table->decimal('unit_price', 10, 2);
            $table->decimal('discount_amount', 10, 2)->default(0);
            $table->decimal('line_total', 10, 2);
            $table->string('variant_info')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            $table->index('product_upc');
        });

        // Subscription Orders (generated orders from subscriptions)
        Schema::create('subscription_orders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('subscription_id')->constrained('subscriptions')->onDelete('cascade');
            $table->integer('order_id')->unsigned();
            $table->integer('sequence_number')->default(1);
            $table->enum('status', ['pending', 'processing', 'completed', 'failed', 'skipped'])->default('pending');
            $table->date('scheduled_date');
            $table->date('processed_date')->nullable();
            $table->text('notes')->nullable();
            $table->string('failure_reason')->nullable();
            $table->timestamps();

            $table->index(['subscription_id', 'sequence_number']);
            $table->index('order_id');
        });

        // Subscription History (audit trail)
        Schema::create('subscription_history', function (Blueprint $table) {
            $table->id();
            $table->foreignId('subscription_id')->constrained('subscriptions')->onDelete('cascade');
            $table->unsignedBigInteger('user_id')->nullable();
            $table->enum('action', [
                'created', 'updated', 'paused', 'resumed', 'cancelled',
                'item_added', 'item_removed', 'item_updated',
                'frequency_changed', 'address_changed', 'payment_changed',
                'order_placed', 'order_skipped', 'order_failed'
            ]);
            $table->json('old_values')->nullable();
            $table->json('new_values')->nullable();
            $table->text('notes')->nullable();
            $table->string('ip_address', 45)->nullable();
            $table->timestamps();

            $table->index('user_id');
        });

        // ===========================================
        // Add pet-related columns to existing tables
        // ===========================================

        // Add pet columns to products table
        if (Schema::hasTable('products') && !Schema::hasColumn('products', 'primary_pet_type_id')) {
            Schema::table('products', function (Blueprint $table) {
                $table->unsignedBigInteger('primary_pet_type_id')->nullable();
                $table->boolean('is_subscription_eligible')->default(false);
                $table->integer('subscription_discount_percentage')->default(5);
            });
        }

        // Add pet_type_id to categories table
        if (Schema::hasTable('categories') && !Schema::hasColumn('categories', 'pet_type_id')) {
            Schema::table('categories', function (Blueprint $table) {
                $table->unsignedBigInteger('pet_type_id')->nullable();
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Remove added columns from existing tables
        if (Schema::hasColumn('products', 'primary_pet_type_id')) {
            Schema::table('products', function (Blueprint $table) {
                $table->dropColumn(['primary_pet_type_id', 'is_subscription_eligible', 'subscription_discount_percentage']);
            });
        }

        if (Schema::hasColumn('categories', 'pet_type_id')) {
            Schema::table('categories', function (Blueprint $table) {
                $table->dropColumn('pet_type_id');
            });
        }

        // Drop tables in reverse order due to foreign key constraints
        Schema::dropIfExists('subscription_history');
        Schema::dropIfExists('subscription_orders');
        Schema::dropIfExists('subscription_items');
        Schema::dropIfExists('subscriptions');
        Schema::dropIfExists('pet_product_recommendations');
        Schema::dropIfExists('customer_pets');
        Schema::dropIfExists('product_size_suitability');
        Schema::dropIfExists('product_life_stages');
        Schema::dropIfExists('product_pet_types');
        Schema::dropIfExists('pet_breeds');
        Schema::dropIfExists('pet_types');
    }
};
