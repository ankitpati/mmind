package MMind::Util::Unbless;

use strict;
use warnings;

use base qw(Exporter);

our @EXPORT_OK = qw(retrieve_all_unbless);

sub dbi_unbless {
    my $obj = shift;
    my %unblessed;
    $unblessed{$_} = $obj->$_ foreach $obj->columns;
    return %unblessed;
}

sub retrieve_all_unbless {
    my $dbi_class = shift;

    my @dbi_objects = $dbi_class->retrieve_all;

    my @obj_array_unbless;
    push @obj_array_unbless, { dbi_unbless $_ }
        foreach $dbi_class->retrieve_all;

    return @obj_array_unbless;
}

1;
