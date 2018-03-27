package MMind::Config;

use strict;
use warnings;

use base qw(Exporter MMind::DBI);

our @EXPORT_OK = qw(getconfig);

__PACKAGE__->table ('config');
__PACKAGE__->columns (all => qw(key val));
__PACKAGE__->columns (Primary => qw(key));

our %config;

sub getconfig {
    my $key = shift;

    return
        $config{$key} //
        $ENV{$key} //
        __PACKAGE__->retrieve ($key)
    ;
}

1;
