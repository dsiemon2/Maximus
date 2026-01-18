<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class FooterConfigSeeder extends Seeder
{
    /**
     * Seed the footer configuration with default structure.
     */
    public function run(): void
    {
        // Create footer columns
        $columns = [
            ['id' => 1, 'title' => 'Shop', 'position' => 1, 'is_visible' => true, 'column_type' => 'links'],
            ['id' => 2, 'title' => 'Resources', 'position' => 2, 'is_visible' => true, 'column_type' => 'links'],
            ['id' => 3, 'title' => 'Customer Service', 'position' => 3, 'is_visible' => true, 'column_type' => 'links'],
            ['id' => 4, 'title' => 'Newsletter Signup', 'position' => 4, 'is_visible' => true, 'column_type' => 'newsletter'],
        ];

        foreach ($columns as $column) {
            DB::table('footer_columns')->updateOrInsert(
                ['position' => $column['position']],
                [
                    'title' => $column['title'],
                    'is_visible' => $column['is_visible'],
                    'column_type' => $column['column_type'],
                    'created_at' => now(),
                    'updated_at' => now()
                ]
            );
        }

        // Get column IDs (in case they differ from insert order)
        $shopColumnId = DB::table('footer_columns')->where('position', 1)->value('id');
        $resourcesColumnId = DB::table('footer_columns')->where('position', 2)->value('id');
        $customerServiceColumnId = DB::table('footer_columns')->where('position', 3)->value('id');

        // Shop column links
        $shopLinks = [
            ['label' => 'Home', 'url' => '/', 'sort_order' => 1, 'is_core' => true, 'feature_flag' => null],
            ['label' => 'All Products', 'url' => '/products', 'sort_order' => 2, 'is_core' => true, 'feature_flag' => null],
            ['label' => 'Special Products', 'url' => '/products?special=1', 'sort_order' => 3, 'is_core' => false, 'feature_flag' => 'specialty_products'],
            ['label' => 'Gift Cards', 'url' => '/gift-cards', 'sort_order' => 4, 'is_core' => false, 'feature_flag' => 'gift_cards'],
            ['label' => 'Shopping Cart', 'url' => '/cart', 'sort_order' => 5, 'is_core' => true, 'feature_flag' => null],
        ];

        foreach ($shopLinks as $link) {
            DB::table('footer_links')->updateOrInsert(
                ['column_id' => $shopColumnId, 'label' => $link['label']],
                [
                    'url' => $link['url'],
                    'icon' => 'bi-chevron-right',
                    'feature_flag' => $link['feature_flag'],
                    'link_type' => 'internal',
                    'sort_order' => $link['sort_order'],
                    'is_visible' => true,
                    'is_core' => $link['is_core'],
                    'created_at' => now(),
                    'updated_at' => now()
                ]
            );
        }

        // Resources column links
        $resourcesLinks = [
            ['label' => 'Blog', 'url' => '/blog', 'sort_order' => 1, 'is_core' => false, 'feature_flag' => 'blog'],
            ['label' => 'Events', 'url' => '/events', 'sort_order' => 2, 'is_core' => false, 'feature_flag' => 'events'],
            ['label' => 'Pet Care Guides', 'url' => '/pet-care', 'sort_order' => 3, 'is_core' => false, 'feature_flag' => null],
            ['label' => 'FAQ', 'url' => '/faq', 'sort_order' => 4, 'is_core' => false, 'feature_flag' => 'faq'],
            ['label' => 'About Us', 'url' => '/about', 'sort_order' => 5, 'is_core' => true, 'feature_flag' => null],
        ];

        foreach ($resourcesLinks as $link) {
            DB::table('footer_links')->updateOrInsert(
                ['column_id' => $resourcesColumnId, 'label' => $link['label']],
                [
                    'url' => $link['url'],
                    'icon' => 'bi-chevron-right',
                    'feature_flag' => $link['feature_flag'],
                    'link_type' => 'internal',
                    'sort_order' => $link['sort_order'],
                    'is_visible' => true,
                    'is_core' => $link['is_core'],
                    'created_at' => now(),
                    'updated_at' => now()
                ]
            );
        }

        // Customer Service column links
        $customerServiceLinks = [
            ['label' => 'Contact Us', 'url' => '/contact', 'sort_order' => 1, 'is_core' => true, 'feature_flag' => null],
            ['label' => 'Tell-A-Friend', 'url' => '/tell-a-friend', 'sort_order' => 2, 'is_core' => false, 'feature_flag' => 'tell_a_friend'],
            ['label' => 'Shipping Policy', 'url' => '/shipping', 'sort_order' => 3, 'is_core' => true, 'feature_flag' => null],
            ['label' => 'Return Policy', 'url' => '/returns', 'sort_order' => 4, 'is_core' => true, 'feature_flag' => null],
            ['label' => 'Privacy Policy', 'url' => '/privacy', 'sort_order' => 5, 'is_core' => true, 'feature_flag' => null],
        ];

        foreach ($customerServiceLinks as $link) {
            DB::table('footer_links')->updateOrInsert(
                ['column_id' => $customerServiceColumnId, 'label' => $link['label']],
                [
                    'url' => $link['url'],
                    'icon' => 'bi-chevron-right',
                    'feature_flag' => $link['feature_flag'],
                    'link_type' => 'internal',
                    'sort_order' => $link['sort_order'],
                    'is_visible' => true,
                    'is_core' => $link['is_core'],
                    'created_at' => now(),
                    'updated_at' => now()
                ]
            );
        }
    }
}
