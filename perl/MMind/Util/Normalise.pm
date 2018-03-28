package MMind::Util::Normalise;

use strict;
use warnings;

use base qw(Exporter);

use MMind::Crypt::Password qw(get_hash);

our @EXPORT_OK = qw(normalise_phone normalise_password normalise_email);

sub normalise_password {
    return get_hash shift;
}

sub normalise_phone {
    return $_[0] =~ s/\s//g; # remove all spaces
}

sub normalise_email {
    return lc shift; # lowercase
}

1;
