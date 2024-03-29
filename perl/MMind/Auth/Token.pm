package MMind::Auth::Token;

use strict;
use warnings;

use base qw(Exporter);

use MMind::Users;
use MMind::Crypt::Password qw(verify_password);
use MMind::Crypt::Token qw(get_token get_payload);

our @EXPORT_OK = qw(get_auth_token verify_auth_token);

sub get_auth_token {
    my %details = @_;
        # phone OR email
        # password

    my $user = MMind::Users->search (%details);
    return unless $user;

    $details{password} = $user->password;
        # for later verification, and invalidation upon password change

    $details{role_id } = $user->role_id;

    return get_token \%details;
}

sub verify_auth_token {
    my $details = get_payload shift;
    return unless ref $details; # bogus token, could not be parsed

    my %search_hash;
    $search_hash{phone} = $details->{phone} if $details->{phone};
    $search_hash{email} = $details->{email} if $details->{email};

    my @user = MMind::Users->search (%search_hash);
    return unless @user; # user no longer exists in database
    die "Multiple users found with given details!\n" if @user > 1;

    my $user = shift @user;

    return unless
        $user &&
        $details->{password} eq $user->password &&
        $details->{role_id } eq $user->role_id;
            # user     no longer exists in database
            # password has changed since the token was generated
            # role     has changed since the token was generated

    return %$details;
}

1;
