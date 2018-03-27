package MMind::REST::API;

use strict;
use warnings;

use base qw(Apache2::REST::Handler);

sub GET {
    my ($self, $req, $res) = @_;
    $res->data->{api_mess} = "Welcome to MMind!\n";
    return Apache2::Const::HTTP_OK;
}

sub isAuth {
    my ($self, $method, $req) = @_;
    return $method eq 'GET' || $method eq 'POST';
}

1;
