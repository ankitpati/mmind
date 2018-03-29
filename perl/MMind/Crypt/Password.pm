package MMind::Crypt::Password;

use strict;
use warnings;

use base qw(Exporter);

use Crypt::Eksblowfish::Bcrypt qw(bcrypt en_base64);
use Crypt::Random qw(makerandom_octet);

our @EXPORT_OK = qw(get_hash verify_password);

sub get_hash {
    my $password = shift;

    my $settings = '$2a$08$';
        # 2a: algorithm, bcrypt with NUL appended to key
        # 08: cost, 2**8 operations

    my $salt = en_base64 makerandom_octet Length => 16;

    return bcrypt $password, $settings.$salt;
}

sub verify_password {
    my ($password, $hash) = @_;
    return bcrypt ($password, $hash) eq $hash;
}

1;
