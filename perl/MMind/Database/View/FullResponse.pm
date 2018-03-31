package MMind::Database::View::FullResponse;

use strict;
use warnings;

use base qw(MMind::DBI);

use Carp;

__PACKAGE__->table ('full_response');
__PACKAGE__->columns (All => qw(user_id month year turnover
                                hsn_code sales purchase trade_margin));
__PACKAGE__->columns (Primary => qw(user_id month year));

sub new {
    croak "Cannot insert into a database view!\n";
}

1;
