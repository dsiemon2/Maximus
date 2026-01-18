<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PetDataSeeder extends Seeder
{
    /**
     * Seed pet types, breeds, and update settings for Maximus Pet Store
     */
    public function run(): void
    {
        $this->seedPetTypes();
        $this->seedPetBreeds();
        $this->updateSettings();
    }

    private function seedPetTypes(): void
    {
        $petTypes = [
            [
                'name' => 'Dogs',
                'slug' => 'dogs',
                'description' => 'Food, toys, treats, beds, grooming supplies, and accessories for dogs of all sizes and breeds.',
                'icon' => 'dog',
                'sort_order' => 1,
                'is_active' => true,
            ],
            [
                'name' => 'Cats',
                'slug' => 'cats',
                'description' => 'Premium food, litter, toys, scratching posts, and accessories for cats.',
                'icon' => 'cat',
                'sort_order' => 2,
                'is_active' => true,
            ],
            [
                'name' => 'Birds',
                'slug' => 'birds',
                'description' => 'Bird food, cages, perches, toys, and accessories for pet birds.',
                'icon' => 'bird',
                'sort_order' => 3,
                'is_active' => true,
            ],
            [
                'name' => 'Fish',
                'slug' => 'fish',
                'description' => 'Aquariums, fish food, filters, decorations, and supplies for freshwater and saltwater fish.',
                'icon' => 'fish',
                'sort_order' => 4,
                'is_active' => true,
            ],
            [
                'name' => 'Small Pets',
                'slug' => 'small-pets',
                'description' => 'Supplies for rabbits, guinea pigs, hamsters, gerbils, and other small animals.',
                'icon' => 'rabbit',
                'sort_order' => 5,
                'is_active' => true,
            ],
            [
                'name' => 'Reptiles',
                'slug' => 'reptiles',
                'description' => 'Terrariums, heating, lighting, food, and supplies for reptiles and amphibians.',
                'icon' => 'lizard',
                'sort_order' => 6,
                'is_active' => true,
            ],
        ];

        foreach ($petTypes as $petType) {
            DB::table('pet_types')->updateOrInsert(
                ['slug' => $petType['slug']],
                array_merge($petType, [
                    'created_at' => now(),
                    'updated_at' => now(),
                ])
            );
        }
    }

    private function seedPetBreeds(): void
    {
        // Get pet type IDs
        $dogId = DB::table('pet_types')->where('slug', 'dogs')->value('id');
        $catId = DB::table('pet_types')->where('slug', 'cats')->value('id');

        if ($dogId) {
            $dogBreeds = [
                ['name' => 'Labrador Retriever', 'size_category' => 'large'],
                ['name' => 'German Shepherd', 'size_category' => 'large'],
                ['name' => 'Golden Retriever', 'size_category' => 'large'],
                ['name' => 'French Bulldog', 'size_category' => 'small'],
                ['name' => 'Bulldog', 'size_category' => 'medium'],
                ['name' => 'Poodle', 'size_category' => 'medium'],
                ['name' => 'Beagle', 'size_category' => 'medium'],
                ['name' => 'Rottweiler', 'size_category' => 'large'],
                ['name' => 'Dachshund', 'size_category' => 'small'],
                ['name' => 'Yorkshire Terrier', 'size_category' => 'small'],
                ['name' => 'Boxer', 'size_category' => 'large'],
                ['name' => 'Siberian Husky', 'size_category' => 'large'],
                ['name' => 'Great Dane', 'size_category' => 'giant'],
                ['name' => 'Chihuahua', 'size_category' => 'small'],
                ['name' => 'Shih Tzu', 'size_category' => 'small'],
                ['name' => 'Boston Terrier', 'size_category' => 'small'],
                ['name' => 'Pomeranian', 'size_category' => 'small'],
                ['name' => 'Corgi', 'size_category' => 'medium'],
                ['name' => 'Australian Shepherd', 'size_category' => 'medium'],
                ['name' => 'Mixed Breed', 'size_category' => null],
            ];

            foreach ($dogBreeds as $breed) {
                $slug = Str::slug($breed['name']);
                DB::table('pet_breeds')->updateOrInsert(
                    ['pet_type_id' => $dogId, 'slug' => $slug],
                    [
                        'pet_type_id' => $dogId,
                        'name' => $breed['name'],
                        'slug' => $slug,
                        'size_category' => $breed['size_category'],
                        'is_active' => true,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]
                );
            }
        }

        if ($catId) {
            $catBreeds = [
                ['name' => 'Persian', 'size_category' => 'medium'],
                ['name' => 'Maine Coon', 'size_category' => 'large'],
                ['name' => 'Siamese', 'size_category' => 'medium'],
                ['name' => 'British Shorthair', 'size_category' => 'medium'],
                ['name' => 'Ragdoll', 'size_category' => 'large'],
                ['name' => 'Bengal', 'size_category' => 'medium'],
                ['name' => 'Abyssinian', 'size_category' => 'medium'],
                ['name' => 'Scottish Fold', 'size_category' => 'medium'],
                ['name' => 'Sphynx', 'size_category' => 'medium'],
                ['name' => 'Russian Blue', 'size_category' => 'medium'],
                ['name' => 'Mixed Breed', 'size_category' => null],
            ];

            foreach ($catBreeds as $breed) {
                $slug = Str::slug($breed['name']);
                DB::table('pet_breeds')->updateOrInsert(
                    ['pet_type_id' => $catId, 'slug' => $slug],
                    [
                        'pet_type_id' => $catId,
                        'name' => $breed['name'],
                        'slug' => $slug,
                        'size_category' => $breed['size_category'],
                        'is_active' => true,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]
                );
            }
        }
    }

    private function updateSettings(): void
    {
        $settings = [
            // General Settings
            ['group' => 'general', 'key' => 'site_name', 'value' => 'Maximus Pet Store', 'type' => 'string'],
            ['group' => 'general', 'key' => 'site_tagline', 'value' => 'Premium Pet Supplies for Happy Pets', 'type' => 'string'],
            ['group' => 'general', 'key' => 'site_description', 'value' => 'Your one-stop shop for premium pet food, toys, treats, and accessories. We carry top brands for dogs, cats, birds, fish, small pets, and reptiles.', 'type' => 'text'],
            ['group' => 'general', 'key' => 'business_name', 'value' => 'Maximus Pet Store LLC', 'type' => 'string'],
            ['group' => 'general', 'key' => 'timezone', 'value' => 'America/New_York', 'type' => 'string'],
            ['group' => 'general', 'key' => 'currency_code', 'value' => 'USD', 'type' => 'string'],
            ['group' => 'general', 'key' => 'currency_symbol', 'value' => '$', 'type' => 'string'],

            // Contact Settings
            ['group' => 'contact', 'key' => 'contact_email', 'value' => 'hello@maximuspetstore.com', 'type' => 'string'],
            ['group' => 'contact', 'key' => 'support_email', 'value' => 'support@maximuspetstore.com', 'type' => 'string'],
            ['group' => 'contact', 'key' => 'contact_phone', 'value' => '1-800-PET-SHOP', 'type' => 'string'],

            // SEO Settings
            ['group' => 'seo', 'key' => 'meta_title', 'value' => 'Maximus Pet Store - Premium Pet Supplies', 'type' => 'string'],
            ['group' => 'seo', 'key' => 'meta_description', 'value' => 'Shop premium pet food, toys, treats, beds, and accessories for dogs, cats, birds, fish, small pets, and reptiles. Free shipping on orders over $49.', 'type' => 'text'],

            // Feature Settings
            ['group' => 'features', 'key' => 'autoship_enabled', 'value' => '1', 'type' => 'boolean'],
            ['group' => 'features', 'key' => 'autoship_discount_percentage', 'value' => '10', 'type' => 'integer'],
            ['group' => 'features', 'key' => 'pet_profiles_enabled', 'value' => '1', 'type' => 'boolean'],
        ];

        foreach ($settings as $setting) {
            DB::table('settings')->updateOrInsert(
                ['setting_group' => $setting['group'], 'setting_key' => $setting['key']],
                [
                    'setting_group' => $setting['group'],
                    'setting_key' => $setting['key'],
                    'setting_value' => $setting['value'],
                    'setting_type' => $setting['type'],
                    'updated_at' => now(),
                ]
            );
        }
    }
}
