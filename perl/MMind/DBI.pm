package MMind::DBI;

use base qw(Class::DBI);

my $database = $ENV{'MMIND_DATABASE'};
my $host     = $ENV{'MMIND_HOST'    };
my $username = $ENV{'MMIND_USERNAME'};
my $password = $ENV{'MMIND_PASSWORD'};

__PACKAGE__->connection ("dbi:mysql:database=$database:host=$host",
                         $username, $password);

1;
