<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class FeaturedCategoriesSeeder extends Seeder
{
    /**
     * Seed the featured categories table with default sample data.
     * These are example categories - replace with actual category IDs for your store.
     */
    public function run(): void
    {
        // Sample pet store categories - update these IDs to match your actual categories
        $featuredCategories = [
            [
                'category_id' => 100,  // Dogs
                'label' => "Dog Supplies",
                'description' => "Everything for your canine companion. Food, treats, toys, beds, and more.",
                'sort_order' => 1,
            ],
            [
                'category_id' => 200,  // Cats
                'label' => "Cat Supplies",
                'description' => "Premium products for cats. Food, litter, toys, scratchers, and accessories.",
                'sort_order' => 2,
            ],
            [
                'category_id' => 300,  // Birds
                'label' => 'Bird Supplies',
                'description' => 'Everything for pet birds. Seeds, cages, toys, and cage accessories.',
                'sort_order' => 3,
            ],
            [
                'category_id' => 400,  // Fish
                'label' => "Fish & Aquarium",
                'description' => 'Aquarium supplies and fish food for freshwater and saltwater fish.',
                'sort_order' => 4,
            ],
            [
                'category_id' => 500,  // Small Pets
                'label' => "Small Pets",
                'description' => "For rabbits, hamsters, guinea pigs & more small animals.",
                'sort_order' => 5,
            ],
            [
                'category_id' => 600,  // Reptiles
                'label' => 'Reptile Supplies',
                'description' => 'Terrariums, heating, lighting, and food for reptiles.',
                'sort_order' => 6,
            ],
        ];

        foreach ($featuredCategories as $category) {
            DB::table('featured_categories')->updateOrInsert(
                ['category_id' => $category['category_id']],
                array_merge($category, [
                    'created_at' => now(),
                    'updated_at' => now(),
                ])
            );
        }
    }
}
