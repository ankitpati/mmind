package MMind::ResponseLines;

use strict;
use warnings;

use base qw(MMind::DBI);

use Carp;
use MMind::Util::Validate qw(month);
use MMind::ResponseLines;

__PACKAGE__->table ('response_lines');
__PACKAGE__->columns (All => qw(response_line_id user_id month
                                hsn_code sales purchase trade_margin));
__PACKAGE__->constrain_column (month => sub { validate_month $_ });

sub new {
    my $class = shift;

    local $class->db_Main->{AutoCommit};
        # turn off auto-commit until this goes out of scope

    my $response_line;
    eval {
        $response_line = __PACKAGE__->insert ({
            user_id      => shift,
            month        => shift,
            hsn_code     => shift,
            sales        => shift,
            purchase     => shift,
            trade_margin => shift,
        });
    };
    if ($@) {
        $class->dbi_rollback;
        die "Could not add ResponseLine!\n";
    }

    return $response_line;
}

1;
