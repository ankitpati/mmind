package MMind::Config;

use strict;
use warnings;

use base qw(Exporter MMind::DBI);

our @EXPORT_OK = qw(getconfig);

__PACKAGE__->table ('config');
__PACKAGE__->columns (All => qw(key val));

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
