package MMind::REST::API::auth;

use strict;
use warnings;

use base qw(MMind::REST::API);

use MMind::Auth::Token qw(get_auth_token);

sub GET {
    my ($self, $req, $res) = @_;

    my $email    = $req->param ('email'   );
    my $phone    = $req->param ('phone'   );
    my $password = $req->param ('password');

    unless (($email xor $phone) && $password) {
        $res->data->{usage_rest} = '/api/auth/(email|phone)/sha512(password)';
        $res->data->{usage_get } = '/api/auth/'.
                                   '?(email|phone)=&password=sha512(password)';
        $res->data->{authorised} = 'false';
        return Apache2::Const::HTTP_UNAUTHORIZED;
    }

    my %auth_details = (password => $password);
    $auth_details{email} = $email if $email;
    $auth_details{phone} = $phone if $phone;

    my $token = get_auth_token %auth_details;

    unless ($token) {
        $res->data->{authorised} = 'false';
        return Apache2::Const::HTTP_UNAUTHORIZED;
    }

    $res->data->{authorised} = 'true';
    $res->data->{token} = $token;
    return Apache2::Const::HTTP_OK;
}

1;
