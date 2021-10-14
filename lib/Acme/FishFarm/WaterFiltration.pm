package Acme::FishFarm::WaterFiltration;

use 5.006;
use strict;
use warnings;

=head1 NAME

Acme::FishFarm::WaterFiltration - Water Filter for Acme::FishFarm

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

    use Acme::FishFarm::WaterFiltration;

    my $foo = Acme::FishFarm::WaterFiltration->new();
    ...

=head1 EXPORT

None

=head1 DESCRIPTION

This module assumes a cool water filter with a filtering cylinder constantly filtering water in 
the tank. It has inlet, outlet and a drainage valves. The drainage valve is only opened when the
cleaners are switched on automatically to remove waste from the cylinder. To be honest, those cleaners look more like spatulas to me :)

This feature is based on the water filter found L<here|https://www.filternox.com/filters/spt-wbv-mr/>

=head1 CREATION SUBROUTINES/METHODS

=head2 install ( $waste_threshold )

Installs a water filtration system.

C<waste_threshold> is optional and the default value is 75.

The C<$waste_threshold> is the maximum limit of waste in the cylinder. When this count is hit, it 
will turn on the cleaners / spatulas or whatever it's called :).

We'll just assume the range of C<0> to C<100> for this waste counter.

=cut

sub install {...}


=head1 WASTE LEVEL DETECTING SUBROUTINES/METHODS

=head2 read_waste_counter ()

Gets the current waste count.

=cut

sub read_waste_counter {...}

=head2 get_waste_counter_threshold ()

Gets the waste count threshold.

=cut

sub get_waste_counter_threshold {...}

=head2 set_waste_counter_threshold ()

Sets the waste count threshold.

=cut

sub set_waste_counter_threshold {...}


=head1 CLEANING RELATED SUBROUTINES/METHODS

=head2 turn_on_spatulas ()

Turns on the cleaning mechanism ie spins the spatulas :)

The spatulas will scrub the waste off the filter lining. This means the waste count will drop.

The spatulas should be turned on until the waste count is 0 before turning off. This should be 
implemented in the main script.

=head2 turn_off_spatulas ()

Turns off the spatulas and watch the waster counter rise again. :)

=cut

sub turn_on_spatulas {...}

sub turn_off_spatulas {...}

=head1 AUTHOR

Raphael Jong Jun Jie, C<< <ellednera at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-. at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=.>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Acme::FishFarm::WaterFiltration


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

1; # End of Acme::FishFarm::WaterFiltration
