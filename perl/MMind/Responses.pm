package MMind::Responses;

use strict;
use warnings;

use base qw(MMind::DBI);

use Carp;
use MMind::Util::Validate qw(validate_month validate_year);
use MMind::ResponseLines;

__PACKAGE__->table ('responses');
__PACKAGE__->columns (All => qw(user_id month year turnover));
__PACKAGE__->columns (Primary => qw(user_id month year));
__PACKAGE__->has_many (response_lines => qw(MMind::ResponseLines));
__PACKAGE__->constrain_column (month => sub { validate_month $_ });
__PACKAGE__->constrain_column (year => sub { validate_year $_ });

sub new {
    my $class = shift;

    local $class->db_Main->{AutoCommit};
        # turn off auto-commit until this goes out of scope

    my ($user_id, $month, $year) = (shift, shift, shift);

    my $ret = __PACKAGE__->insert ({
        user_id  => $user_id,
        month    => $month,
        year     => $year,
        turnover => shift,
    });

    eval {
        new MMind::ResponseLines ($user_id, $month, $year, @$_) foreach @_;
    };
    if ($@) {
        $class->dbi_rollback;
        die "Could not add Response!\n";
    }

    return $ret;
}

1;
