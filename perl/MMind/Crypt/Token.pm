package MMind::Crypt::Token;

use strict;
use warnings;

use base qw(Exporter);

use Crypt::JWT qw(encode_jwt decode_jwt);

use MMind::Config qw(getconfig);

our EXPORT_OK = qw(get_token get_payload);

my ($alg, $key) = getconfig 'token_algorithm', 'token_secret_symmetric';

sub get_token {
    return encode_jwt payload => shift, alg => $alg, key => $key;
}

sub get_payload {
    return decode_jwt token => shift, accepted_alg => $alg, key => $key;
}

1;
