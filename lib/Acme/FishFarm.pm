package Acme::FishFarm;

use 5.006;
use strict;
use warnings;

=head1 NAME

Acme::FishFarm - A fish farm that has automated systems

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use Acme::FishFarm;


=head1 EXPORT

None by default


=head1 CREATION RELATED METHODS

=head2 new ()

Creates a new fish farm.

=cut

sub new {...}

=head2 install ( systems => [...] )

Installs the specified systems to your fish farm. This is done by setting the C<systems> key.

The values for C<systems> include:

=over 4

=item * water_level

=item * feeder

=item * water_filter

=item * water_monitor

#=item * oxygen_level

=back

To install all the systems in one go, use the C<install_all_systems> method instead.

=cut

sub install {...}

=head2 install_all_systems ()

Installs all the systems available in the fish farm. See C<install> method for the available systems

=cut

sub install_all_systems {...}


=head1 WATER LEVEL MAINTAINER SUBROUTINES/METHODS

=head2 check_water_level ()

Returns the current water level in your pond, tank, aquarium or whatever.

=cut

sub check_water_level {...}


=head1 AUTOMATED FEEDER SUBROUTINES/METHODS

=head2 check_feeder () ??? maybe for refilling :)

Returns the amount (volume) of fish food in the feeder. 

This is only useful if you want to see how much fish food is still there. This is not an important feature of this module

=cut

sub check_feeder {...}


=head1 WATER FILTRATION SUBROUTINES/METHODS

=head2 check_water_filter () ??? maybe just to inspect for fun :)

Returns the amount of waste in the filtering cylinder.

=cut

sub check_water_filter {...}


=head1 WATER CONDITION MONITORING SUBROUTINES/METHODS

=head2 check_water_monitor ()

Returns a hash of the current condition of the water. The hash will include the following keys:

=over 4

=item 1. pH

The values are in the range of 1-14

=item 2. temperature

The ranges of values are between 0 and 50 degree B<celciuls>

=item 3. DO

The range of values are between 0 and 10 mg/L

=item 4. turbidity

The range of values are between 0 and 300 ntu.

=back

=cut

sub check_water_monitor {...}

=head1 OXYGEN LEVEL MAINTAINER SUBROUTINES/METHODS

=head2 check_oxygen_level ()

This is the same as checking the DO content through the C<check_water_filter> method.

Either this part of the DO part might be removed

=cut

sub check_oxygen_level {...}

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
