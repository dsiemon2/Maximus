<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PetCategoriesProductsSeeder extends Seeder
{
    /**
     * Seed pet categories and sample products
     */
    public function run(): void
    {
        $this->seedCategories();
        $this->seedProducts();
    }

    private function seedCategories(): void
    {
        // Get pet type IDs
        $petTypes = DB::table('pet_types')->pluck('id', 'slug')->toArray();

        $categories = [
            // Top level categories (Level 0)
            ['CategoryCode' => 100, 'Category' => 'Dog Supplies', 'ShrtDescription' => 'Everything for your canine companion', 'Level' => 0, 'IsBottom' => 0, 'sOrder' => 1, 'pet_type_id' => $petTypes['dogs'] ?? null],
            ['CategoryCode' => 200, 'Category' => 'Cat Supplies', 'ShrtDescription' => 'Premium products for cats', 'Level' => 0, 'IsBottom' => 0, 'sOrder' => 2, 'pet_type_id' => $petTypes['cats'] ?? null],
            ['CategoryCode' => 300, 'Category' => 'Bird Supplies', 'ShrtDescription' => 'Everything for pet birds', 'Level' => 0, 'IsBottom' => 0, 'sOrder' => 3, 'pet_type_id' => $petTypes['birds'] ?? null],
            ['CategoryCode' => 400, 'Category' => 'Fish & Aquarium', 'ShrtDescription' => 'Aquarium supplies and fish food', 'Level' => 0, 'IsBottom' => 0, 'sOrder' => 4, 'pet_type_id' => $petTypes['fish'] ?? null],
            ['CategoryCode' => 500, 'Category' => 'Small Pet Supplies', 'ShrtDescription' => 'For rabbits, hamsters, guinea pigs & more', 'Level' => 0, 'IsBottom' => 0, 'sOrder' => 5, 'pet_type_id' => $petTypes['small-pets'] ?? null],
            ['CategoryCode' => 600, 'Category' => 'Reptile Supplies', 'ShrtDescription' => 'Terrariums, heating, and reptile food', 'Level' => 0, 'IsBottom' => 0, 'sOrder' => 6, 'pet_type_id' => $petTypes['reptiles'] ?? null],

            // Dog subcategories (Level 1)
            ['CategoryCode' => 101, 'Category' => 'Dog Food', 'ShrtDescription' => 'Premium dry and wet dog food', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 1, 'pet_type_id' => $petTypes['dogs'] ?? null],
            ['CategoryCode' => 102, 'Category' => 'Dog Treats', 'ShrtDescription' => 'Healthy treats and chews', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 2, 'pet_type_id' => $petTypes['dogs'] ?? null],
            ['CategoryCode' => 103, 'Category' => 'Dog Toys', 'ShrtDescription' => 'Interactive and chew toys', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 3, 'pet_type_id' => $petTypes['dogs'] ?? null],
            ['CategoryCode' => 104, 'Category' => 'Dog Beds & Furniture', 'ShrtDescription' => 'Comfortable beds and crates', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 4, 'pet_type_id' => $petTypes['dogs'] ?? null],
            ['CategoryCode' => 105, 'Category' => 'Dog Collars & Leashes', 'ShrtDescription' => 'Walking essentials', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 5, 'pet_type_id' => $petTypes['dogs'] ?? null],
            ['CategoryCode' => 106, 'Category' => 'Dog Grooming', 'ShrtDescription' => 'Shampoos, brushes, and grooming tools', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 6, 'pet_type_id' => $petTypes['dogs'] ?? null],

            // Cat subcategories (Level 1)
            ['CategoryCode' => 201, 'Category' => 'Cat Food', 'ShrtDescription' => 'Premium dry and wet cat food', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 1, 'pet_type_id' => $petTypes['cats'] ?? null],
            ['CategoryCode' => 202, 'Category' => 'Cat Treats', 'ShrtDescription' => 'Delicious cat treats', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 2, 'pet_type_id' => $petTypes['cats'] ?? null],
            ['CategoryCode' => 203, 'Category' => 'Cat Toys', 'ShrtDescription' => 'Interactive toys for cats', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 3, 'pet_type_id' => $petTypes['cats'] ?? null],
            ['CategoryCode' => 204, 'Category' => 'Cat Litter & Accessories', 'ShrtDescription' => 'Litter boxes and litter', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 4, 'pet_type_id' => $petTypes['cats'] ?? null],
            ['CategoryCode' => 205, 'Category' => 'Cat Scratchers & Trees', 'ShrtDescription' => 'Scratching posts and cat trees', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 5, 'pet_type_id' => $petTypes['cats'] ?? null],
            ['CategoryCode' => 206, 'Category' => 'Cat Beds & Carriers', 'ShrtDescription' => 'Cozy beds and travel carriers', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 6, 'pet_type_id' => $petTypes['cats'] ?? null],

            // Bird subcategories
            ['CategoryCode' => 301, 'Category' => 'Bird Food', 'ShrtDescription' => 'Seeds, pellets, and bird food', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 1, 'pet_type_id' => $petTypes['birds'] ?? null],
            ['CategoryCode' => 302, 'Category' => 'Bird Cages', 'ShrtDescription' => 'Cages and habitats', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 2, 'pet_type_id' => $petTypes['birds'] ?? null],
            ['CategoryCode' => 303, 'Category' => 'Bird Toys & Perches', 'ShrtDescription' => 'Toys and cage accessories', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 3, 'pet_type_id' => $petTypes['birds'] ?? null],

            // Fish subcategories
            ['CategoryCode' => 401, 'Category' => 'Fish Food', 'ShrtDescription' => 'Flakes, pellets, and frozen food', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 1, 'pet_type_id' => $petTypes['fish'] ?? null],
            ['CategoryCode' => 402, 'Category' => 'Aquariums & Tanks', 'ShrtDescription' => 'Tanks and aquarium kits', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 2, 'pet_type_id' => $petTypes['fish'] ?? null],
            ['CategoryCode' => 403, 'Category' => 'Filters & Pumps', 'ShrtDescription' => 'Filtration and water circulation', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 3, 'pet_type_id' => $petTypes['fish'] ?? null],

            // Small Pets subcategories
            ['CategoryCode' => 501, 'Category' => 'Small Pet Food', 'ShrtDescription' => 'Food for rabbits, hamsters, guinea pigs', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 1, 'pet_type_id' => $petTypes['small-pets'] ?? null],
            ['CategoryCode' => 502, 'Category' => 'Small Pet Habitats', 'ShrtDescription' => 'Cages and enclosures', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 2, 'pet_type_id' => $petTypes['small-pets'] ?? null],
            ['CategoryCode' => 503, 'Category' => 'Small Pet Bedding', 'ShrtDescription' => 'Bedding and nesting materials', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 3, 'pet_type_id' => $petTypes['small-pets'] ?? null],

            // Reptile subcategories
            ['CategoryCode' => 601, 'Category' => 'Reptile Food', 'ShrtDescription' => 'Live, frozen, and prepared food', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 1, 'pet_type_id' => $petTypes['reptiles'] ?? null],
            ['CategoryCode' => 602, 'Category' => 'Terrariums', 'ShrtDescription' => 'Tanks and terrariums', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 2, 'pet_type_id' => $petTypes['reptiles'] ?? null],
            ['CategoryCode' => 603, 'Category' => 'Heating & Lighting', 'ShrtDescription' => 'Heat lamps and UVB lighting', 'Level' => 1, 'IsBottom' => 1, 'sOrder' => 3, 'pet_type_id' => $petTypes['reptiles'] ?? null],
        ];

        foreach ($categories as $category) {
            DB::table('categories')->updateOrInsert(
                ['CategoryCode' => $category['CategoryCode']],
                $category
            );
        }
    }

    private function seedProducts(): void
    {
        // Get pet type IDs
        $petTypes = DB::table('pet_types')->pluck('id', 'slug')->toArray();

        $products = [
            // Dog Food
            ['UPC' => 'DOG-FOOD-001', 'Description' => 'Premium Adult Dog Food - Chicken & Rice 30lb', 'Company' => 'Maximus Premium', 'Price' => 54.99, 'Unit_price' => 54.99, 'CategoryCode' => 101, 'Qty_avail' => 100, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'DOG-FOOD-002', 'Description' => 'Grain-Free Dog Food - Salmon 25lb', 'Company' => 'Maximus Premium', 'Price' => 64.99, 'Unit_price' => 64.99, 'CategoryCode' => 101, 'Qty_avail' => 75, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'DOG-FOOD-003', 'Description' => 'Puppy Food - Small Breed 15lb', 'Company' => 'Maximus Premium', 'Price' => 42.99, 'Unit_price' => 42.99, 'CategoryCode' => 101, 'Qty_avail' => 50, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'DOG-FOOD-004', 'Description' => 'Senior Dog Food - Joint Support 20lb', 'Company' => 'Maximus Premium', 'Price' => 49.99, 'Unit_price' => 49.99, 'CategoryCode' => 101, 'Qty_avail' => 60, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 1],

            // Dog Treats
            ['UPC' => 'DOG-TREAT-001', 'Description' => 'Natural Bully Sticks 12-Pack', 'Company' => 'Pawstruck', 'Price' => 29.99, 'Unit_price' => 29.99, 'CategoryCode' => 102, 'Qty_avail' => 200, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'DOG-TREAT-002', 'Description' => 'Training Treats - Chicken Flavor 16oz', 'Company' => 'Pupford', 'Price' => 14.99, 'Unit_price' => 14.99, 'CategoryCode' => 102, 'Qty_avail' => 150, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'DOG-TREAT-003', 'Description' => 'Dental Chews - Large Dogs 30ct', 'Company' => 'Maximus Premium', 'Price' => 24.99, 'Unit_price' => 24.99, 'CategoryCode' => 102, 'Qty_avail' => 100, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 1],

            // Dog Toys
            ['UPC' => 'DOG-TOY-001', 'Description' => 'KONG Classic Dog Toy - Large', 'Company' => 'KONG', 'Price' => 16.99, 'Unit_price' => 16.99, 'CategoryCode' => 103, 'Qty_avail' => 80, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 0],
            ['UPC' => 'DOG-TOY-002', 'Description' => 'Squeaky Plush Toy - Duck', 'Company' => 'Multipet', 'Price' => 12.99, 'Unit_price' => 12.99, 'CategoryCode' => 103, 'Qty_avail' => 120, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 0],
            ['UPC' => 'DOG-TOY-003', 'Description' => 'Rope Tug Toy - Heavy Duty', 'Company' => 'Ethical Pet', 'Price' => 9.99, 'Unit_price' => 9.99, 'CategoryCode' => 103, 'Qty_avail' => 150, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 0],

            // Dog Beds
            ['UPC' => 'DOG-BED-001', 'Description' => 'Orthopedic Memory Foam Dog Bed - Large', 'Company' => 'Alpha Paw', 'Price' => 79.99, 'Unit_price' => 79.99, 'CategoryCode' => 104, 'Qty_avail' => 40, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 0],
            ['UPC' => 'DOG-BED-002', 'Description' => 'Cozy Donut Bed - Medium', 'Company' => 'Maximus Premium', 'Price' => 44.99, 'Unit_price' => 44.99, 'CategoryCode' => 104, 'Qty_avail' => 60, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 0],

            // Dog Collars & Leashes
            ['UPC' => 'DOG-COLLAR-001', 'Description' => 'Adjustable Nylon Collar - Blue', 'Company' => 'Coastal Pet', 'Price' => 12.99, 'Unit_price' => 12.99, 'CategoryCode' => 105, 'Qty_avail' => 100, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 0],
            ['UPC' => 'DOG-LEASH-001', 'Description' => 'Retractable Leash - 16ft', 'Company' => 'Coastal Pet', 'Price' => 24.99, 'Unit_price' => 24.99, 'CategoryCode' => 105, 'Qty_avail' => 75, 'primary_pet_type_id' => $petTypes['dogs'] ?? null, 'is_subscription_eligible' => 0],

            // Cat Food
            ['UPC' => 'CAT-FOOD-001', 'Description' => 'Premium Adult Cat Food - Indoor 16lb', 'Company' => 'Maximus Premium', 'Price' => 39.99, 'Unit_price' => 39.99, 'CategoryCode' => 201, 'Qty_avail' => 100, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'CAT-FOOD-002', 'Description' => 'Grain-Free Cat Food - Chicken 12lb', 'Company' => 'Maximus Premium', 'Price' => 44.99, 'Unit_price' => 44.99, 'CategoryCode' => 201, 'Qty_avail' => 80, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'CAT-FOOD-003', 'Description' => 'Wet Cat Food Variety Pack - 24 cans', 'Company' => 'Maximus Premium', 'Price' => 34.99, 'Unit_price' => 34.99, 'CategoryCode' => 201, 'Qty_avail' => 60, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 1],

            // Cat Treats
            ['UPC' => 'CAT-TREAT-001', 'Description' => 'Freeze-Dried Chicken Treats 3oz', 'Company' => 'Vital Essentials', 'Price' => 12.99, 'Unit_price' => 12.99, 'CategoryCode' => 202, 'Qty_avail' => 120, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'CAT-TREAT-002', 'Description' => 'Catnip Treats - Crunchy 6oz', 'Company' => 'Maximus Premium', 'Price' => 8.99, 'Unit_price' => 8.99, 'CategoryCode' => 202, 'Qty_avail' => 150, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 1],

            // Cat Toys
            ['UPC' => 'CAT-TOY-001', 'Description' => 'Interactive Feather Wand', 'Company' => 'Ethical Pet', 'Price' => 9.99, 'Unit_price' => 9.99, 'CategoryCode' => 203, 'Qty_avail' => 100, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 0],
            ['UPC' => 'CAT-TOY-002', 'Description' => 'Laser Pointer Cat Toy', 'Company' => 'Ethical Pet', 'Price' => 7.99, 'Unit_price' => 7.99, 'CategoryCode' => 203, 'Qty_avail' => 150, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 0],
            ['UPC' => 'CAT-TOY-003', 'Description' => 'Catnip Mouse Toy 3-Pack', 'Company' => 'Multipet', 'Price' => 6.99, 'Unit_price' => 6.99, 'CategoryCode' => 203, 'Qty_avail' => 200, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 0],

            // Cat Litter
            ['UPC' => 'CAT-LITTER-001', 'Description' => 'Clumping Cat Litter - Unscented 40lb', 'Company' => 'Maximus Premium', 'Price' => 24.99, 'Unit_price' => 24.99, 'CategoryCode' => 204, 'Qty_avail' => 80, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'CAT-LITTER-002', 'Description' => 'Crystal Cat Litter 8lb', 'Company' => 'Maximus Premium', 'Price' => 19.99, 'Unit_price' => 19.99, 'CategoryCode' => 204, 'Qty_avail' => 60, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 1],

            // Cat Trees
            ['UPC' => 'CAT-TREE-001', 'Description' => 'Multi-Level Cat Tree - 72 inch', 'Company' => 'Maximus Premium', 'Price' => 129.99, 'Unit_price' => 129.99, 'CategoryCode' => 205, 'Qty_avail' => 25, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 0],
            ['UPC' => 'CAT-SCRATCH-001', 'Description' => 'Cardboard Scratcher with Catnip', 'Company' => 'Ethical Pet', 'Price' => 14.99, 'Unit_price' => 14.99, 'CategoryCode' => 205, 'Qty_avail' => 100, 'primary_pet_type_id' => $petTypes['cats'] ?? null, 'is_subscription_eligible' => 0],

            // Bird Food
            ['UPC' => 'BIRD-FOOD-001', 'Description' => 'Premium Parakeet Seed Mix 5lb', 'Company' => 'Maximus Premium', 'Price' => 14.99, 'Unit_price' => 14.99, 'CategoryCode' => 301, 'Qty_avail' => 80, 'primary_pet_type_id' => $petTypes['birds'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'BIRD-FOOD-002', 'Description' => 'Cockatiel Food Blend 4lb', 'Company' => 'Maximus Premium', 'Price' => 16.99, 'Unit_price' => 16.99, 'CategoryCode' => 301, 'Qty_avail' => 60, 'primary_pet_type_id' => $petTypes['birds'] ?? null, 'is_subscription_eligible' => 1],

            // Fish Food
            ['UPC' => 'FISH-FOOD-001', 'Description' => 'Tropical Fish Flakes 4oz', 'Company' => 'Maximus Premium', 'Price' => 8.99, 'Unit_price' => 8.99, 'CategoryCode' => 401, 'Qty_avail' => 150, 'primary_pet_type_id' => $petTypes['fish'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'FISH-FOOD-002', 'Description' => 'Betta Fish Pellets 1oz', 'Company' => 'Maximus Premium', 'Price' => 5.99, 'Unit_price' => 5.99, 'CategoryCode' => 401, 'Qty_avail' => 200, 'primary_pet_type_id' => $petTypes['fish'] ?? null, 'is_subscription_eligible' => 1],

            // Small Pet Food
            ['UPC' => 'SMALL-FOOD-001', 'Description' => 'Timothy Hay - Premium Cut 96oz', 'Company' => 'Maximus Premium', 'Price' => 22.99, 'Unit_price' => 22.99, 'CategoryCode' => 501, 'Qty_avail' => 60, 'primary_pet_type_id' => $petTypes['small-pets'] ?? null, 'is_subscription_eligible' => 1],
            ['UPC' => 'SMALL-FOOD-002', 'Description' => 'Guinea Pig Pellets 5lb', 'Company' => 'Maximus Premium', 'Price' => 14.99, 'Unit_price' => 14.99, 'CategoryCode' => 501, 'Qty_avail' => 80, 'primary_pet_type_id' => $petTypes['small-pets'] ?? null, 'is_subscription_eligible' => 1],
        ];

        foreach ($products as $product) {
            $product['Weight'] = '1 lb';
            $product['UOM'] = 'EA';
            $product['ProductType'] = 'STD';
            $product['Sold_out'] = 'N';
            $product['Mark_up'] = 30;

            DB::table('products')->updateOrInsert(
                ['UPC' => $product['UPC']],
                $product
            );
        }
    }
}
