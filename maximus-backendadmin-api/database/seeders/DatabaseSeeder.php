<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Create admin user for Maximus Pet Store
        User::factory()->create([
            'name' => 'Admin User',
            'email' => 'admin@maximuspetstore.com',
        ]);

        // Seed pet types, breeds, and settings
        $this->call([
            PetDataSeeder::class,
            PetSuppliersSeeder::class,
            SettingsSeeder::class,
        ]);
    }
}
