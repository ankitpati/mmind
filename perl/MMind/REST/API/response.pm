package MMind::REST::API::response;

use strict;
use warnings;

use base qw(MMind::REST::API);

use MMind::Config qw(getconfig);
use MMind::Auth::Token qw(verify_auth_token);
use MMind::Responses;
use MMind::Database::View::FullResponse;
use MMind::Util::Unbless qw(dbi_unbless_list);

my $unpriv_uid = getconfig 'minimum_unprivileged_user_id';

sub GET {
    my ($self, $req, $res) = @_;

    my $authorisation_header = $req->headers_in->{Authorization};
    return Apache2::Const::HTTP_UNAUTHORIZED unless $authorisation_header;

    $authorisation_header =~ s/^Bearer //;

    my %payload = verify_auth_token $authorisation_header;
    return Apache2::Const::HTTP_UNAUTHORIZED
        unless %payload && $payload{role_id} < $unpriv_uid;

    $res->data->{responses} =
        [dbi_unbless_list (MMind::Database::View::FullResponse->retrieve_all)];
    return Apache2::Const::HTTP_OK;
}

1;
