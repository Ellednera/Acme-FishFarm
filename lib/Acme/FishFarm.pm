package Acme::FishFarm;

use 5.006;
use strict;
use warnings;
use Carp "croak";

use Acme::FishFarm::Feeder;
use Acme::FishFarm::OxygenMaintainer;
use Acme::FishFarm::WaterConditionMonitor;

=head1 NAME

Acme::FishFarm - A fish farm with automated systems

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use Acme::FishFarm;


=head1 EXPORT

The tag C<:all> can be used to import all the functions available in this module.

=cut

use Exporter qw( import );
our @EXPORT_OK = qw( 
    install_all_systems 
    reduce_precision consume_oxygen 
    check_DO check_pH check_temperature check_turbidity
    render_leds render_buzzer
);
our %EXPORT_TAGS = ( 
    all => [ qw( install_all_systems reduce_precision consume_oxygen check_DO check_pH check_temperature 
                 check_turbidity render_leds render_buzzer ) ],
);

=head1 SYSTEM INSTALLATION RELATED SUBROUTINES

=head2 install_all_systems

Installs all the available systems with default values and returns them as a list of C<Acme::FishFarm::*> objects in the following sequence:

    C<(Feeder, OxygenMaintainer, WaterConditionMonitor, WaterLevelMaintainer, WaterFiltration)>

=cut

sub install_all_systems {
    my $feeder = Acme::FishFarm::Feeder->install;
    my $oxygen_maintainer = Acme::FishFarm::OxygenMaintainer->install;
    my $water_monitor = Acme::FishFarm::WaterConditionMonitor->install;
    my $water_level = "";
    my $water_filter = "";
    
    # remember to connect water oxygem maintainer to water condition monitoring :)
    $water_monitor->add_oxygen_maintainer( $oxygen_maintainer );
    
    ( $feeder, $oxygen_maintainer, $water_monitor, $water_level, $water_filter );
}


=head1 SENSOR READING RELATED SUBROUTINES

=head2 reduce_precision ( $decimal )

Reduces C<$decimal> to a maximum of 3 decimal points. Make sure to pass in a decimal with more than 3 decimal points.

Returns the reduced 3-decimal value.

This subroutine is useful if you are trying to set the current sensor readings randomly using the built-in C<rand> function as you do not want to end up with too many decimals on the screen.

=cut

sub reduce_precision {
    my $sensor_reading = shift;
    croak "Please pass in a decimal value" if not $sensor_reading =~ /\./;
    $sensor_reading =~ /(\d+\.\d{3})/;
    $1;
}

=head1 AUTOMATED SYSTEMS RELATED SUBROUTINES

All of the subroutines here will give output.

=head2 consume_oxygen ( $oxygen_maintainer, $consumed_oxygen )

This will cause the oxygen level (DO level) of the C<Acme::FishFarm::OxygenMaintainer> to reduce by C<$consumed_oxygen mg/L>

Returns 1 upon success.
=cut

sub consume_oxygen {
    my $o2_maintainer = shift;
    my $consumed_oxygen = shift;
    print "$consumed_oxygen mg/L of oxygen consumed...\n";
    my $o2_remaining = $o2_maintainer->current_DO - $consumed_oxygen;
    $o2_maintainer->current_DO( $o2_remaining );
    1;
}

=head2 check_DO ( $oxygen_maintainer, $current_DO_reading )

This checks and outputs the condition of the current DO level.

Take note that this process will also trigger the LED and buzzer if abnormal condition is present.

Returns 1 upon success.
=cut

sub check_DO {
    my ( $oxygen, $current_reading ) = @_;
    my $DO_threshold = $oxygen->DO_threshold;

    $oxygen->current_DO( $current_reading );
    $oxygen->is_low_DO;
    
    print "Current Oxygen Level: ", $current_reading, " mg/L",
        " (low: < ", $DO_threshold, ")\n";

    if ( $oxygen->is_low_DO ) {
        print "  !! Low oxygen level!\n";
    } else {
        print "  Oxygen level is normal.\n";
    }
    1;
}

=head2 check_pH ( $water_monitor, $current_ph_reading )

This checks and outputs the condition of the current pH value.

Take note that this process will also trigger the LED and buzzer if abnormal condition is present.

Returns 1 upon success.

=cut

sub check_pH {
    my ( $water_monitor, $current_reading ) = @_;
    my $ph_range = $water_monitor->ph_threshold;
    
    $water_monitor->current_ph( $current_reading );
    $water_monitor->ph_is_normal;
    
    print "Current pH: ", $water_monitor->current_ph, 
        " (normal range: ", $ph_range->[0], "~", $ph_range->[1], ")\n";

    if ( !$water_monitor->ph_is_normal ) {
        print "  !! Abnormal pH!\n";
    } else {
        print "  pH is normal.\n";
    }
    1;
}

=head2 check_temperature ( $water_monitor, $current_temperature_reading )

This checks and outputs the condition of the current temperature.

Take note that this process will also trigger the LED and buzzer if abnormal condition is present.

Returns 1 upon success.

=cut

sub check_temperature {
    my ( $water_monitor, $current_reading ) = @_;
    my $temperature_range = $water_monitor->temperature_threshold;

    $water_monitor->current_temperature( $current_reading );
    $water_monitor->temperature_is_normal;
    
    print "Current temperature: ", $water_monitor->current_temperature, " C", 
        " (normal range: ", $temperature_range->[0], " C ~ ", $temperature_range->[1], " C)\n";

    if ( !$water_monitor->temperature_is_normal ) {
        print "  !! Abnormal temperature!\n";
    } else {
        print "  Temperature is normal.\n";
    }
    1;
}

=head2 check_turbidity ( $water_monitor, $current_turbidity_reading )

This checks and outputs the condition of the current temperature.

Take note that this process will also trigger the LED and buzzer if abnormal condition is present.

Returns 1 upon success.

=cut

sub check_turbidity {
    my ( $water_monitor, $current_reading ) = @_;
    my $turbidity_threshold = $water_monitor->turbidity_threshold;

    $water_monitor->current_turbidity( $current_reading );
    
    print "Current Turbidity: ", $water_monitor->current_turbidity, " ntu",
        " (dirty: > ", $turbidity_threshold, ")";

    if ( $water_monitor->water_dirty ) {
        print "  !! Water is dirty!\n";
    } else {
        print "  Water is still clean.\n";
    }
    1;
}

=head2 render_leds ( $water_monitor )

Outputs which LEDs are lighted up. Returns 1 upon success.

Currently this subroutine only shows the LEDs present in C<$water_monitor> ie. C<Acme::FishFarm::WaterConditionMonitor> object. See that module for more details about the available LEDs.

More LEDs will be available in the future. You can append your own LEDs by yourself if you really need to :)

=cut

sub render_leds {
    my $water_monitor = shift;

    # must check condition first! If not it won't work
        # this process will update the LEDs status
    $water_monitor->ph_is_normal;
    $water_monitor->temperature_is_normal;
    $water_monitor->lacking_oxygen;    
    $water_monitor->water_dirty;
        
    print "Total LEDs up: ", $water_monitor->lighted_LED_count, "\n";

    if ( $water_monitor->is_on_LED_pH ) {
        print "  pH LED: on\n";
    } else {
        print "  pH LED: off\n";
    }
    
    if ( $water_monitor->is_on_LED_temperature ) {
        print "  Temperature LED: on\n";
    } else {
        print "  Temperature LED: off\n";
    }
    
    if ( $water_monitor->is_on_LED_DO ) {
        print "  Low DO LED: on\n";
    } else {
        print "  Low DO LED: off\n";
    }
    
    if ( $water_monitor->is_on_LED_turbidity ) {
        print "  Turbidity LED: on\n";
    } else {
        print "  Turbidity LED: off\n";
    }
    1;
}

=head2 render_buzzer ( $water_monitor )

Outputs which buzzer is buzzing. Returns 1 upon success.

See C<Acme::FishFarm::WaterConditionMonitor> for details on how the short and long buzzers are switched on and off.

=cut

sub render_buzzer {
    my $water_monitor = shift;
    
    #$water_monitor->_tweak_buzzers;
    if ( $water_monitor->is_on_buzzer_long ) {
        print "Long buzzer is on, water condition very critical!\n";
    } elsif ( $water_monitor->is_on_buzzer_short ) {
        print "Short buzzer is on, water condition is a bit worrying :|\n";
    } else {
        print "No buzzers on, what a peaceful moment.\n";
    }
    1;
}

=head1 AUTHOR

Raphael Jong Jun Jie, C<< <ellednera at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-acme-fishfarm at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Acme-FishFarm>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Acme::FishFarm


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Acme-FishFarm>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Acme-FishFarm>

=item * Search CPAN

L<https://metacpan.org/release/Acme-FishFarm>

=back


=head1 ACKNOWLEDGEMENTS

Besiyata d'shmaya

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2021 by Raphael Jong Jun Jie.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)


=cut

1; # End of Acme::FishFarm
