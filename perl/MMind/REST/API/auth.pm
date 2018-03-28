package MMind::REST::API::auth;

use strict;
use warnings;

use base qw(MMind::REST::API);

sub GET {
    my ($self, $req, $res) = @_;
    $res->data->{usage} = "/auth/(email|phone)/sha512(password)";
    return Apache2::Const::HTTP_OK;
}

1;
