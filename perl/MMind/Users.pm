package MMind::Users;

use strict;
use warnings;

use base qw(MMind::DBI);

use Carp;
use MMind::Util::Validate qw(validate_phone validate_email);
use MMind::Util::Normalise qw(normalise_phone normalise_email
                              normalise_password);

__PACKAGE__->table ('users');
__PACKAGE__->columns (All => qw(id realname phone email password role_id));
__PACKAGE__->constrain_column (phone => sub { validate_phone $_ });
__PACKAGE__->constrain_column (email => sub { validate_email $_ });

sub new {
    my $class = shift;

    return __PACKAGE__->insert ({
        realname => shift,
        phone    => shift,
        email    => shift,
        password => shift,
        role_id  => shift,
    });
}

sub normalize_column_values {
    my ($self, $object) = (shift, shift);

    $object->{phone   } = normalise_phone    $phone;
    $object->{email   } = normalise_email    $email;
    $object->{password} = normalise_password $password;
}

1;
