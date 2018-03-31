package MMind::REST::API::response;

use strict;
use warnings;

use base qw(MMind::REST::API);

use MMind::Config qw(getconfig);
use MMind::Auth::Token qw(verify_auth_token);
use MMind::Responses;
use MMind::Users;
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

sub POST {
    my ($self, $req, $res) = @_;

    my $authorisation_header = $req->headers_in->{Authorization};
    return Apache2::Const::HTTP_UNAUTHORIZED unless $authorisation_header;

    $authorisation_header =~ s/^Bearer //;

    my %payload = verify_auth_token $authorisation_header;
    return Apache2::Const::HTTP_UNAUTHORIZED
        unless %payload && $payload{role_id} < $unpriv_uid;

    my $email    = $req->param ('email'   );
    my $phone    = $req->param ('phone'   );
    my $month    = $req->param ('month'   );
    my $year     = $req->param ('year'    );
    my $turnover = $req->param ('turnover');

    unless (($email xor $phone) && $month && $year && $turnover) {
        $res->data->{usage_post} = <<'EOT';
POST /api/response HTTP/1.1
Authorization: Bearer long.jwe.token

(phone|email)=&month=&year=&turnover=
EOT
        return Apache2::Const::HTTP_UNAUTHORIZED;
    }

    my %search_hash;
    $search_hash{phone} = $phone if $phone;
    $search_hash{email} = $email if $email;
    my @users = MMind::Users->search (%search_hash);

    return Apache2::Const::HTTP_EXPECTATION_FAILED unless @users == 1;
    my $user = shift @users;

    my $response = MMind::Responses->retrieve (
        user_id => $user->id,
        month   => $month   ,
        year    => $year    ,
    ) || new MMind::Responses ($user->id, $month, $year, $turnover);

    return Apache2::Const::HTTP_INTERNAL_SERVER_ERROR unless $response;
    return Apache2::Const::HTTP_OK;
}

1;
