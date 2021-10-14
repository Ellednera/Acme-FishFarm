#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

BEGIN {
    use_ok( "Acme::FishFarm::Feeder" ) || BAIL_OUT;
}


ok( my $feeder_default = Acme::FishFarm::Feeder->install(), "Feeder installed" ); # timer 1 hour, 50 cm^3 fish food
print $feeder_default, "\n";
is( ref($feeder_default), "Acme::FishFarm::Feeder", "Correct class name");

ok( my $feeder_h5_v15 = Acme::FishFarm::Feeder->install( timer => 5, feeding_volume => 15 ), "Feeder installed" );
is( ref($feeder_h5_v15), "Acme::FishFarm::Feeder", "Correct class name");

ok( my $feeder_h3 = Acme::FishFarm::Feeder->install( timer => 3 ), "Feeder installed" );
is( ref($feeder_h3), "Acme::FishFarm::Feeder", "Correct class name");

ok( my $feeder_v45 = Acme::FishFarm::Feeder->install( feeding_volume => 45 ), "Feeder installed" );
is( ref($feeder_v45), "Acme::FishFarm::Feeder", "Correct class name");

# this shuold get back the default values
ok( my $feeder_all_0 = Acme::FishFarm::Feeder->install( timer =>0, feeding_volume => 0 ), "Feeder installed" );
is( ref($feeder_all_0), "Acme::FishFarm::Feeder", "Correct class name");
is( $feeder_all_0->get_timer(), 8, "Zero hours defaults to 8 hours");
is( $feeder_all_0->feeding_volume(), 50, "Zero cm^3 defaults to 50 cm^3");


is( $feeder_default->get_timer(), 8, "Correct default timer" );


# tick_clock part will go into a loop in the actual program
ok( $feeder_default->tick_clock(), "Clock ticks once ($_)" ) for (0..3);
is( $feeder_default->time_remaining(), 4, "Correct time remaining" );
isnt( $feeder_default->timer_is_up(), 1, "Time isn't up yet'" );
ok( $feeder_default->tick_clock(), "Clock ticks once ($_)" ) for (4..7);
is( $feeder_default->timer_is_up(), 1, "Time to feed the fish'" );

#print $feeder_default->tick_clock() . "\n";
#print $feeder_default->tick_clock() . "\n";
#print $feeder_default->tick_clock() . "\n";

# test food tank
is($feeder_default->food_remaining(), 500, "Correct default food level");
is($feeder_default->feeding_volume(), 50, "Correct default feeding volume");

$feeder_default->set_feeding_volume(25);
is($feeder_default->feeding_volume(), 25, "New feeding volume set");
$feeder_default->refill(10); # "downfill" :)
is($feeder_default->food_remaining(), 10, "Downfill success, please don't do this in the actual program");

$feeder_default->refill; # back to 500
$feeder_default->feed_fish; # feed 25 cm^3
is($feeder_default->food_remaining, 475, "Fed the correct amount of food to the fish");

$feeder_default->feed_fish; # feed 25 cm^3
is($feeder_default->food_remaining, 450, "Fed the correct amount of food to the fish");

{
local $@;
eval { $feeder_default->set_feeding_volume; };
like( $@, qr/Please specify feeding volume/, "Caught feeding volume missing" );
}


done_testing();

# besiyata d'shmaya



