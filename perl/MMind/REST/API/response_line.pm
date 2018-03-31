package MMind::REST::API::response_line;

use strict;
use warnings;

use base qw(MMind::REST::API);

use MMind::Config qw(getconfig);
use MMind::Auth::Token qw(verify_auth_token);
use MMind::Users;
use MMind::ResponseLines;

my $unpriv_uid = getconfig 'minimum_unprivileged_user_id';

sub POST {
    my ($self, $req, $res) = @_;

    my $authorisation_header = $req->headers_in->{Authorization};
    return Apache2::Const::HTTP_UNAUTHORIZED unless $authorisation_header;

    $authorisation_header =~ s/^Bearer //;

    my %payload = verify_auth_token $authorisation_header;
    return Apache2::Const::HTTP_UNAUTHORIZED
        unless %payload && $payload{role_id} < $unpriv_uid;

    my $email        = $req->param ('email'       );
    my $phone        = $req->param ('phone'       );
    my $month        = $req->param ('month'       );
    my $year         = $req->param ('year'        );
    my $hsn_code     = $req->param ('hsn_code'    );
    my $sales        = $req->param ('sales'       );
    my $purchase     = $req->param ('purchase'    );
    my $trade_margin = $req->param ('trade_margin');

    unless (($email xor $phone) && $month && $year && $hsn_code && $sales &&
                                                $purchase && $trade_margin) {
        $res->data->{usage_post} = <<'EOT';
POST /api/response_line HTTP/1.1
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

    my $response_line = MMind::ResponseLines->retrieve (
        user_id      => $user->id    ,
        month        => $month       ,
        year         => $year        ,
        hsn_code     => $hsn_code    ,
        sales        => $sales       ,
        purchase     => $purchase    ,
        trade_margin => $trade_margin,
    ) || new MMind::ResponseLines ($user->id, $month, $year, $hsn_code, $sales,
                                   $purchase, $trade_margin);

    return Apache2::Const::HTTP_INTERNAL_SERVER_ERROR unless $response_line;
    return Apache2::Const::HTTP_OK;
}

1;
