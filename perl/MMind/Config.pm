package MMind::Config;

use strict;
use warnings;

use base qw(Exporter MMind::DBI);

our @EXPORT_OK = qw(getconfig);

__PACKAGE__->table ('config');
__PACKAGE__->columns (All => qw(cfgkey cfgval));

our %config;

sub getconfig {
    my @vals;

    foreach my $key (@_) {
        my $val = $config{$key} // $ENV{$key};

        unless (defined $val) {
            my $cfgobj = __PACKAGE__->retrieve ($key);
            $val = $cfgobj->cfgval if $cfgobj;
        }

        $config{$key} = $val if defined $val;

        push @vals, $val;
    }

    return @vals;
}

1;
