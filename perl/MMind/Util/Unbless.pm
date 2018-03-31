package MMind::Util::Unbless;

use strict;
use warnings;

use base qw(Exporter);

our @EXPORT_OK = qw(dbi_unbless dbi_unbless_list);

sub dbi_unbless {
    my $obj = shift;
    my %unblessed;
    $unblessed{$_} = $obj->$_ foreach $obj->columns;
    return %unblessed;
}

sub dbi_unbless_list {
    my @obj_array_unbless;
    push @obj_array_unbless, { dbi_unbless $_ } foreach @_;
    return @obj_array_unbless;
}

1;
