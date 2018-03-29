package MMind::Crypt::Token;

use strict;
use warnings;

use base qw(Exporter);

use Crypt::JWT qw(encode_jwt decode_jwt);

use MMind::Config qw(getconfig);

our @EXPORT_OK = qw(get_token get_payload);

my ($alg, $key, $relative_exp) = getconfig 'token_algorithm',
                                           'token_secret_symmetric',
                                           'token_relative_expiry_seconds';

sub get_token {
    return encode_jwt payload => shift, alg => $alg, key => $key,
                      auto_iat => 1, relative_exp => $relative_exp;
}

sub get_payload {
    return decode_jwt token => shift, accepted_alg => $alg, key => $key,
                      verify_iat => 1, verify_exp => 1;
}

1;
