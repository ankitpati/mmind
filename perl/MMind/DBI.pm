package MMind::DBI;

use base qw(Class::DBI);

use MMind::Config qw(getconfig);

__PACKAGE__->connection (
    'dbi:mysql' .
    ':database='.getconfig('MMIND_DATABASE') .
    ':host='    .getconfig('MMIND_HOSTNAME') ,
    getconfig ('MMIND_USERNAME'),
    getconfig ('MMIND_PASSWORD')
);

1;
