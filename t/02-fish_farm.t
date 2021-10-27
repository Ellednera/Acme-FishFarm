#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

use Acme::FishFarm ":all";


my ($feeder, $oxygen, $water_monitor, $water_level, $water_filter ) = 
    Acme::FishFarm->install_all_systems;

is( ref($feeder), "Acme::FishFarm::Feeder", "Correct feeder" );
is( ref($oxygen), "Acme::FishFarm::OxygenMaintainer", "Correct oxygem maintainer" );
is( ref($water_monitor), "Acme::FishFarm::WaterConditionMonitor", "Correct water condition monitor" );
#is( ref($water_level), "Acme::FishFarm::WaterLevelMaintainer", "Correct water level monitor" );
#is( ref($water_filter), "Acme::FishFarm::WaterFiltration", "Correct water filter" );

is( reduce_precision(3.14159), 3.141, "reduce_precision is working correctly" );
ok( consume_oxygen( $oxygen, 2.5 ), "consume_oxygen is working correctly");
ok( consume_oxygen( $oxygen, 2 ), "consume_oxygen is working correctly");

ok( check_DO( $oxygen, 5 ), "check_DO is working correctly" );
ok( check_pH( $water_monitor, 5 ), "check_pH is working correctly" );
ok( check_temperature( $water_monitor, 25 ), "check_temperature is working correctly" );
ok( check_turbidity( $water_monitor, 250 ), "check_turbidity is working correctly" );


ok( render_leds( $water_monitor), "render_leds is working correctly" );
ok( render_buzzer( $water_monitor ), "render_buzzer is working correctly" );

done_testing;

# besiyata d'shmaya




