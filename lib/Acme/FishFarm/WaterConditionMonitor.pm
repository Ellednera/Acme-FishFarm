package Acme::FishFarm::WaterConditionMonitor;

use 5.006;
use strict;
use warnings;

=head1 NAME

Acme::FishFarm::WaterConditionMonitor - Water Condition Monitor with Alarm for Acme::FishFarm

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use Acme::FishFarm::WaterConditionMonitor;

    my $foo = Acme::FishFarm::WaterConditionMonitor->new();
    ...

=head1 EXPORT

None

=head1 CREATION RELATED SUBROUTINES/METHODS

=head2 install ( %sensors )

Installs a water condition monitoring system.

The C<%sensors> included are:

=over 4

=item pH

Optional. The default is [6.5, 7.5]. I might be wrong

This will set the threshold value of the water pH. Please pass in an array reference to this key
in the form of C<[min_pH, max_pH]>

The values are in the range of 1-14.

=item temperature

Optional. The default is [20, 25] degree celcius. I might be wrong.

This will set the threshold value of the water temperature. Please pass in an array reference to this key
in the form of C<[min_temperature, max_temperature]>

The ranges of values are between 0 and 50 degree B<celciuls>

=item DO

Optional. The default is 5 mg/L.

This will set the threshold value of the DO in the water.

The range of values are between 0 and 10 mg/L

=item turbidity

Optional. The default is 180 ntu.

This will set the threshold of the turbidity of the water.

The range of values are between 0 and 300 ntu.

=back

=cut

sub install {...}


=head1 WATER CONDITIONS RELATED SUBROUTINES/METHODS

=head2 set_ph_threshold ( $ph_value )

Sets the pH threshold.

=cut

sub set_ph_threshold {...}

=head2 ph_is_normal ()

Returns true if the current pH is within the set range of threshold.

=cut

sub ph_is_normal {...}

=head2 set_temperature_threshold ( $celcius )

Sets the water temperature threshold.

=cut

sub set_temperature_threshold {...}

=head2 temperature_is_normal ()

Returns true if the current temperature is within the set range of threshold.

=cut

sub temperature_is_normal {...}

=head2 lacking_oxygen ()

Returns true if the current DO content is lower then the threshold.

=cut

sub lacking_oxygen {...}

=head2 water_dirty ()

Returns true if the current turbidity is highter then the threshold.

=cut

sub water_dirty {...}


# these 2 should be wrappers of something in the future
=head1 BUZZER RELATED SUBROUTINES/METHODS

=head2 buzz_short ()

Makes the buzzer buzz for a while if only one LED is lighted up.

=cut

sub buzz_short {...}

=head2 buzz_long ()

Makes the buzzer buzz infinitely until less than 2 LEDs are lighted up.

=cut

sub buzz_long {...}



=head1 LED LIGHTS RELATED SUBROUTINES/METHODS

An LED is lighted up if the corresponding parameter are in an abnormal state.
This action is to be done in through the main script.

=head2 on_LED_pH ()

Light up the LED for pH sensor, indicating abnormal pH.

=head2 is_on_LED_pH ()

Returns true if the LED of pH is lighted up.

=cut

sub on_LED_pH {...}

sub is_on_LED_pH {...}

=head2 on_LED_temperature ()

Light up the LED for temperature sensor, indicating abnormal water temperature.

=head2 is_on_LED_temperature ()

Returns true if the LED of temperature is lighted up.

=cut

sub on_LED_temperature {...}

sub is_on_LED_temperature {...}

=head2 on_LED_DO ()

Light up the LED for dissolved oxygen sensor, indicating low DO content. Fish might die :)

=head2 is_on_LED_DO ()

Returns true if the LED of DO is lighted up.

=cut

sub on_LED_DO {...}

sub is_on_LED_DO {...}

=head2 on_LED_turbidity ()

Light up the LED for turbidity sensor, indicating high level of waste etc. Fish might die :)

=head2 is_on_LED_turbidity ()

Returns true if the LED of DO is lighted up.

=cut

sub on_LED_turbidity {...}

sub is_on_LED_turbidity {...}

=head1 AUTHOR

Raphael Jong Jun Jie, C<< <ellednera at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-. at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=.>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Acme::FishFarm::WaterConditionMonitor


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=.>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/.>

=item * Search CPAN

L<https://metacpan.org/release/.>

=back


=head1 ACKNOWLEDGEMENTS

Besiyata d'shmaya

=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2021 by Raphael Jong Jun Jie.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)


=cut

1; # End of Acme::FishFarm::WaterConditionMonitor
