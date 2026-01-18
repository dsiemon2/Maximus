<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PetSuppliersSeeder extends Seeder
{
    /**
     * Seed pet suppliers and dropshippers
     * Data sourced from pet_suppliers_nice_full_Combine.md
     */
    public function run(): void
    {
        // Disable foreign key checks for truncation
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');

        // Clear existing PRT suppliers
        DB::table('suppliers')->truncate();
        DB::table('dropshippers')->truncate();

        // Re-enable foreign key checks
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        $this->seedSuppliers();
        $this->seedDropshippers();
    }

    private function seedSuppliers(): void
    {
        $suppliers = [
            ['company_name' => 'Wholesale Pet', 'contact_name' => 'Sales Team', 'email' => 'sales@wholesalepet.com', 'phone' => '1-800-555-0101', 'address' => '123 Pet Supply Blvd', 'city' => 'Dallas', 'state' => 'TX', 'postal_code' => '75201', 'payment_terms' => 'Net 30', 'notes' => 'Wholesaler - Food, Toys, Grooming. US-based with large catalog.'],
            ['company_name' => 'Pet Edge', 'contact_name' => 'Account Manager', 'email' => 'accounts@petedge.com', 'phone' => '1-800-555-0102', 'address' => '456 Grooming Lane', 'city' => 'Beverly', 'state' => 'MA', 'postal_code' => '01915', 'payment_terms' => 'Net 30', 'notes' => 'Wholesaler - Grooming, Beds, Apparel. Professional grooming supplies.'],
            ['company_name' => 'Mirage Pet Products', 'contact_name' => 'Private Label Dept', 'email' => 'pl@miragepet.com', 'phone' => '1-800-555-0103', 'address' => '789 Apparel Ave', 'city' => 'Los Angeles', 'state' => 'CA', 'postal_code' => '90001', 'payment_terms' => 'Net 45', 'notes' => 'Manufacturer - Apparel, Accessories, Collars. Full private label available.'],
            ['company_name' => 'Doggie Design', 'contact_name' => 'Wholesale Team', 'email' => 'wholesale@doggiedesign.com', 'phone' => '1-800-555-0104', 'address' => '321 Fashion Dr', 'city' => 'Miami', 'state' => 'FL', 'postal_code' => '33101', 'payment_terms' => 'Net 30', 'notes' => 'Wholesaler - Apparel, Harnesses, Leads. Some PL options.'],
            ['company_name' => 'Pet Palette', 'contact_name' => 'Orders Dept', 'email' => 'orders@petpalette.com', 'phone' => '1-800-555-0105', 'address' => '555 Toy Street', 'city' => 'Chicago', 'state' => 'IL', 'postal_code' => '60601', 'payment_terms' => 'Net 30', 'notes' => 'Wholesaler - Toys, Treats. US-based.'],
            ['company_name' => 'BaxterBoo Wholesale', 'contact_name' => 'B2B Sales', 'email' => 'b2b@baxterboo.com', 'phone' => '1-800-555-0106', 'address' => '888 Pet Blvd', 'city' => 'Portland', 'state' => 'OR', 'postal_code' => '97201', 'payment_terms' => 'Net 30', 'notes' => 'Wholesaler - Premium apparel and accessories.'],
            ['company_name' => 'PetStoreDirect', 'contact_name' => 'Wholesale Dept', 'email' => 'wholesale@petstoredirect.com', 'phone' => '1-800-555-0107', 'address' => '999 Grooming Way', 'city' => 'Seattle', 'state' => 'WA', 'postal_code' => '98101', 'payment_terms' => 'Net 30', 'notes' => 'Wholesaler - Grooming, Shampoos specialist.'],
            ['company_name' => 'Natural Dog Company', 'contact_name' => 'Wholesale', 'email' => 'wholesale@naturaldogcompany.com', 'phone' => '1-800-555-0108', 'address' => '111 Natural Way', 'city' => 'Denver', 'state' => 'CO', 'postal_code' => '80201', 'payment_terms' => 'Net 30', 'notes' => 'Manufacturer - Balms, Skin Care. Private label available.'],
            ['company_name' => 'Bulk Apothecary Pet', 'contact_name' => 'Pet Division', 'email' => 'pet@bulkapothecary.com', 'phone' => '1-800-555-0109', 'address' => '222 Bulk Road', 'city' => 'Columbus', 'state' => 'OH', 'postal_code' => '43201', 'payment_terms' => 'Net 45', 'notes' => 'Manufacturer - Grooming Supplies, Shampoos. Private label.'],
            ['company_name' => 'Pupford Wholesale', 'contact_name' => 'B2B Team', 'email' => 'b2b@pupford.com', 'phone' => '1-800-555-0110', 'address' => '333 Training Lane', 'city' => 'Austin', 'state' => 'TX', 'postal_code' => '78701', 'payment_terms' => 'Net 30', 'notes' => 'Manufacturer - Training Treats specialist.'],
            ['company_name' => 'Jones Natural Chews', 'contact_name' => 'Sales', 'email' => 'sales@jonesnaturalchews.com', 'phone' => '1-800-555-0111', 'address' => '444 Chew Ave', 'city' => 'Kansas City', 'state' => 'KS', 'postal_code' => '66101', 'payment_terms' => 'Net 30', 'notes' => 'Wholesaler - Natural dog chews and treats.'],
            ['company_name' => 'Pawstruck Wholesale', 'contact_name' => 'Private Label', 'email' => 'pl@pawstruck.com', 'phone' => '1-800-555-0112', 'address' => '555 Bully Lane', 'city' => 'Phoenix', 'state' => 'AZ', 'postal_code' => '85001', 'payment_terms' => 'Net 30', 'notes' => 'Manufacturer - Bully Sticks, Chews. Private label available.'],
            ['company_name' => 'Pet Food Experts', 'contact_name' => 'Distribution', 'email' => 'info@petfoodexperts.com', 'phone' => '1-800-555-0113', 'address' => '666 Food Dr', 'city' => 'Providence', 'state' => 'RI', 'postal_code' => '02901', 'payment_terms' => 'Net 30', 'notes' => 'Distributor - Major pet food distributor.'],
            ['company_name' => 'Pet Express', 'contact_name' => 'Accounts', 'email' => 'accounts@petexpress.com', 'phone' => '1-800-555-0114', 'address' => '777 Express Way', 'city' => 'Atlanta', 'state' => 'GA', 'postal_code' => '30301', 'payment_terms' => 'Net 30', 'notes' => 'Distributor - Grooming, Food. Fast delivery.'],
            ['company_name' => 'Multipet', 'contact_name' => 'Sales Team', 'email' => 'sales@multipet.com', 'phone' => '1-800-555-0115', 'address' => '888 Toy Blvd', 'city' => 'Carlstadt', 'state' => 'NJ', 'postal_code' => '07072', 'payment_terms' => 'Net 30', 'notes' => 'Manufacturer - Large plush toy manufacturer.'],
            ['company_name' => 'Ethical Pet', 'contact_name' => 'Wholesale', 'email' => 'wholesale@ethicalpet.com', 'phone' => '1-800-555-0116', 'address' => '999 Ethical Ave', 'city' => 'Bloomfield', 'state' => 'NJ', 'postal_code' => '07003', 'payment_terms' => 'Net 30', 'notes' => 'Wholesaler - Toys, Accessories. Ethical/sustainable products.'],
            ['company_name' => 'Redbarn Pet Products', 'contact_name' => 'B2B', 'email' => 'b2b@redbarn.com', 'phone' => '1-800-555-0117', 'address' => '100 Redbarn Rd', 'city' => 'Long Beach', 'state' => 'CA', 'postal_code' => '90801', 'payment_terms' => 'Net 30', 'notes' => 'Manufacturer - Treats, Chews. Some white label options.'],
            ['company_name' => 'NaturVet', 'contact_name' => 'Wholesale Dept', 'email' => 'wholesale@naturvet.com', 'phone' => '1-800-555-0118', 'address' => '200 Supplement St', 'city' => 'Temecula', 'state' => 'CA', 'postal_code' => '92590', 'payment_terms' => 'Net 45', 'notes' => 'Manufacturer - Supplements. Partial private label.'],
            ['company_name' => 'Vital Essentials', 'contact_name' => 'Wholesale', 'email' => 'wholesale@vitalessentials.com', 'phone' => '1-800-555-0119', 'address' => '300 Raw Food Lane', 'city' => 'Green Bay', 'state' => 'WI', 'postal_code' => '54301', 'payment_terms' => 'Net 30', 'notes' => 'Manufacturer - Freeze-dried raw food. Premium quality.'],
            ['company_name' => 'Only Natural Pet', 'contact_name' => 'B2B Sales', 'email' => 'b2b@onlynaturalpet.com', 'phone' => '1-800-555-0120', 'address' => '400 Holistic Way', 'city' => 'Boulder', 'state' => 'CO', 'postal_code' => '80301', 'payment_terms' => 'Net 30', 'notes' => 'Distributor - Treats, Supplements. Holistic/natural focus.'],
            ['company_name' => 'Yellow Dog Design', 'contact_name' => 'PL Team', 'email' => 'privatelabel@yellowdogdesign.com', 'phone' => '1-800-555-0121', 'address' => '500 Collar Blvd', 'city' => 'Charlotte', 'state' => 'NC', 'postal_code' => '28201', 'payment_terms' => 'Net 30', 'notes' => 'Manufacturer - Collars, Leashes. Full private label.'],
            ['company_name' => 'Up Country', 'contact_name' => 'Wholesale', 'email' => 'wholesale@upcountryinc.com', 'phone' => '1-800-555-0122', 'address' => '600 Design Ave', 'city' => 'Boston', 'state' => 'MA', 'postal_code' => '02101', 'payment_terms' => 'Net 30', 'notes' => 'Manufacturer - Designer collars and accessories.'],
            ['company_name' => 'PetAg', 'contact_name' => 'Distribution', 'email' => 'info@petag.com', 'phone' => '1-800-555-0123', 'address' => '700 Milk Lane', 'city' => 'Hampshire', 'state' => 'IL', 'postal_code' => '60140', 'payment_terms' => 'Net 30', 'notes' => 'Manufacturer - Milk Replacers, Supplements. Nursing supplies.'],
            ['company_name' => 'Coastal Pet Products', 'contact_name' => 'Sales', 'email' => 'sales@coastalpet.com', 'phone' => '1-800-555-0124', 'address' => '800 Coastal Dr', 'city' => 'Alliance', 'state' => 'OH', 'postal_code' => '44601', 'payment_terms' => 'Net 30', 'notes' => 'Manufacturer - Collars, Leashes, Harnesses. Major manufacturer.'],
            ['company_name' => 'Worldwise', 'contact_name' => 'B2B', 'email' => 'b2b@worldwise.com', 'phone' => '1-800-555-0125', 'address' => '900 Eco Way', 'city' => 'San Rafael', 'state' => 'CA', 'postal_code' => '94901', 'payment_terms' => 'Net 30', 'notes' => 'Manufacturer - Eco-friendly products and toys.'],
        ];

        foreach ($suppliers as $supplier) {
            DB::table('suppliers')->insert(array_merge($supplier, [
                'country' => 'USA',
                'status' => 'active',
                'created_at' => now(),
                'updated_at' => now(),
            ]));
        }
    }

    private function seedDropshippers(): void
    {
        $dropshippers = [
            ['company_name' => 'PetDropshipper', 'contact_name' => 'Partner Team', 'email' => 'partners@petdropshipper.com', 'phone' => '1-800-555-0201', 'address_line1' => '100 Dropship Ave', 'city' => 'Los Angeles', 'state' => 'CA', 'postal_code' => '90001', 'notes' => 'Toys, Treats, Accessories. Large US catalog. Shopify integration. 3-7 day shipping.'],
            ['company_name' => 'Alpha Paw', 'contact_name' => 'Dropship Dept', 'email' => 'dropship@alphapaw.com', 'phone' => '1-800-555-0202', 'address_line1' => '200 Paw Lane', 'city' => 'San Diego', 'state' => 'CA', 'postal_code' => '92101', 'notes' => 'Beds, Ramps specialist. REST API. 5-10 day shipping.'],
            ['company_name' => 'EPROLO Pets', 'contact_name' => 'Pet Division', 'email' => 'pets@eprolo.com', 'phone' => '86-755-8888-0203', 'address_line1' => '300 Global Way', 'city' => 'Shenzhen', 'state' => '', 'postal_code' => '518000', 'country' => 'China', 'notes' => 'Toys, Accessories. Full API. Some PL. 10-20 day shipping.'],
            ['company_name' => 'CJDropshipping Pets', 'contact_name' => 'Pet Category', 'email' => 'pets@cjdropshipping.com', 'phone' => '86-579-8888-0204', 'address_line1' => '400 CJ Blvd', 'city' => 'Yiwu', 'state' => '', 'postal_code' => '322000', 'country' => 'China', 'notes' => 'Toys, Accessories, Grooming. Full API. Custom packaging. 7-15 day shipping.'],
            ['company_name' => 'Printify Pet Category', 'contact_name' => 'POD Team', 'email' => 'pod@printify.com', 'phone' => '371-2000-0205', 'address_line1' => '500 Print Ave', 'city' => 'Riga', 'state' => '', 'postal_code' => 'LV-1050', 'country' => 'Latvia', 'notes' => 'Custom Pet Apparel, Beds, Bowls. POD platform. Full PL. 5-12 day shipping.'],
            ['company_name' => 'Spocket Pets', 'contact_name' => 'Pet Suppliers', 'email' => 'pets@spocket.co', 'phone' => '1-800-555-0206', 'address_line1' => '600 Spocket Lane', 'city' => 'Vancouver', 'state' => 'BC', 'postal_code' => 'V6B 1A1', 'country' => 'Canada', 'notes' => 'Various Pet Products. US/EU suppliers. 2-7 day shipping.'],
            ['company_name' => 'Modalyst Pets', 'contact_name' => 'Pet Division', 'email' => 'pets@modalyst.co', 'phone' => '1-800-555-0208', 'address_line1' => '800 Modal Ave', 'city' => 'New York', 'state' => 'NY', 'postal_code' => '10001', 'notes' => 'Premium Pet Products. Full API. US-based. 3-7 day shipping.'],
            ['company_name' => 'Wholesale2B Pets', 'contact_name' => 'Pet Team', 'email' => 'pets@wholesale2b.com', 'phone' => '1-800-555-0210', 'address_line1' => '1000 W2B Blvd', 'city' => 'Miami', 'state' => 'FL', 'postal_code' => '33101', 'notes' => 'Pet Supplies. Full integration. 3-7 day shipping.'],
            ['company_name' => 'Inventory Source Pets', 'contact_name' => 'Pet Category', 'email' => 'pets@inventorysource.com', 'phone' => '1-800-555-0211', 'address_line1' => '1100 Inventory Way', 'city' => 'Phoenix', 'state' => 'AZ', 'postal_code' => '85001', 'notes' => 'Pet Products. Full automation. 2-5 day shipping.'],
            ['company_name' => 'Doba Pets', 'contact_name' => 'Pet Suppliers', 'email' => 'pets@doba.com', 'phone' => '1-800-555-0212', 'address_line1' => '1200 Doba Dr', 'city' => 'Orem', 'state' => 'UT', 'postal_code' => '84057', 'notes' => 'Pet Supplies aggregator. 3-7 day shipping.'],
            ['company_name' => 'Sunrise Wholesale Pets', 'contact_name' => 'Pet Division', 'email' => 'pets@sunrisewholesale.com', 'phone' => '1-800-555-0213', 'address_line1' => '1300 Sunrise Blvd', 'city' => 'Chino', 'state' => 'CA', 'postal_code' => '91710', 'notes' => 'Pet Products. CSV/API. US-based. 2-5 day shipping.'],
            ['company_name' => 'Megagoods Pets', 'contact_name' => 'Pet Team', 'email' => 'pets@megagoods.com', 'phone' => '1-800-555-0214', 'address_line1' => '1400 Mega Way', 'city' => 'Los Angeles', 'state' => 'CA', 'postal_code' => '90001', 'notes' => 'Pet Electronics, Accessories. API. 1-3 day US shipping.'],
            ['company_name' => 'Pet Stores USA Dropship', 'contact_name' => 'Partner Program', 'email' => 'partners@petstoresusa.com', 'phone' => '1-800-555-0215', 'address_line1' => '1500 Pet Store Lane', 'city' => 'Dallas', 'state' => 'TX', 'postal_code' => '75201', 'notes' => 'Full Pet Catalog. REST API. Comprehensive. 2-5 day shipping.'],
            ['company_name' => 'PetSupplyPlus Dropship', 'contact_name' => 'Dropship Team', 'email' => 'dropship@petsupplyplus.com', 'phone' => '1-800-555-0216', 'address_line1' => '1600 Supply Dr', 'city' => 'Chicago', 'state' => 'IL', 'postal_code' => '60601', 'notes' => 'Food, Supplies, Accessories. API. 2-5 day shipping.'],
            ['company_name' => 'FurBaby Fulfillment', 'contact_name' => 'Partner Support', 'email' => 'partners@furbabyfulfillment.com', 'phone' => '1-800-555-0217', 'address_line1' => '1700 Fur Way', 'city' => 'Atlanta', 'state' => 'GA', 'postal_code' => '30301', 'notes' => 'Premium pet products. White-glove fulfillment. 2-4 day shipping.'],
        ];

        foreach ($dropshippers as $dropshipper) {
            $record = [
                'company_name' => $dropshipper['company_name'],
                'contact_name' => $dropshipper['contact_name'],
                'email' => $dropshipper['email'],
                'phone' => $dropshipper['phone'],
                'address_line1' => $dropshipper['address_line1'],
                'city' => $dropshipper['city'],
                'state' => $dropshipper['state'],
                'postal_code' => $dropshipper['postal_code'],
                'country' => $dropshipper['country'] ?? 'USA',
                'notes' => $dropshipper['notes'],
                'status' => 'active',
                'commission_rate' => 0.00,
                'created_at' => now(),
                'updated_at' => now(),
            ];
            DB::table('dropshippers')->insert($record);
        }
    }
}
