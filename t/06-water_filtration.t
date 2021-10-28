#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok( "Acme::FishFarm::WaterFiltration" ) || BAIL_OUT;
}

my $water_filter = Acme::FishFarm::WaterFiltration->install;
is( ref($water_filter), "Acme::FishFarm::WaterFiltration", "Correct class" );
is( $water_filter->current_waste_count, 0, "Correct default waste count" );
$water_filter->current_waste_count(50);
is( $water_filter->current_waste_count, 50, "Correct new waste count" );
is( $water_filter->waste_count_threshold, 75, "Correct default waste count threshold" );
$water_filter->set_waste_count_threshold(100);
is( $water_filter->waste_count_threshold, 100, "Correct new waste count threshold" );

$water_filter->current_waste_count(10);
$water_filter->clean_cylinder;
is( $water_filter->current_waste_count, 0, "Cylinder is totaly clean :)" );

is( $water_filter->is_cylinder_dirty, 0, "Cylinder not dirty yet" );
$water_filter->current_waste_count(120);
is( $water_filter->is_cylinder_dirty, 1, "Cylinder is dirty!" );
is( $water_filter->is_filter_layer_dirty, 1, "Synonym 'is_filter_layer_dirty' working" );

# custom installation
my $water_filter_2 = Acme::FishFarm::WaterFiltration->install( 
    current_waste_count => 35, waste_threshold =>50 );
is( $water_filter_2->current_waste_count, 35, "Correct custom waste count" );
is( $water_filter_2->waste_count_threshold, 50, "Correct custom waste count threshold" );
is( $water_filter_2->is_filter_layer_dirty, 0, "Cylinder not dirty yet" );
$water_filter_2->current_waste_count(50);
is( $water_filter_2->is_filter_layer_dirty, 1, "Cylinder is now dirty" );
$water_filter_2->clean_filter_layer;
is( $water_filter_2->current_waste_count, 0, "Synonym 'clean_filter_layer' working" );

done_testing;

# besiyata d'shmaya



