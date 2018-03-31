package MMind::Util::Unbless;

use strict;
use warnings;

use base qw(Exporter);

our @EXPORT_OK = qw(retrieve_all_unbless);

sub retrieve_all_unbless {
    my $dbi_class = shift;

    my @dbi_objects = $dbi_class->retrieve_all;
    my @dbi_columns = $dbi_class->columns;

    my @obj_array_unbless;
    foreach my $obj (@dbi_objects) {
        my %obj_hash_unbless;
        $obj_hash_unbless{$_} = $obj->$_ foreach @dbi_columns;
        push @obj_array_unbless, \%obj_hash_unbless;
    }

    return @obj_array_unbless;
}

1;
