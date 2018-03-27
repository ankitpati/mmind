package MMind::Util::Validate;

use strict;
use warnings;

use base qw(Exporter);

our @EXPORT_OK = qw(validate_phone validate_email);

my $regex_phone = qr/^\+?(?:\d ?){5,15}$/;
my $regex_email = qr/^
    (?:[a-zA-Z0-9]\w*[-+\.])*?  # other parts, delimited by plus, minus, dot
    [a-zA-Z0-9]\w*?             # part immediately preceding @

    @                           # only one @ allowed

    (?:[a-zA-Z0-9]\w*?[-\.])+   # host.domain. (notice the last dot)
    [a-zA-Z0-9]\w+              # TLD (cannot contain only 1 char)
$/x;

sub validate_phone {
    return shift =~ $regex_phone;
}

sub validate_email {
    return shift =~ $regex_email;
}

1;
