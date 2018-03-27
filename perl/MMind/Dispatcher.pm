package MMind::Dispatcher;

use strict;
use warnings;

use MMind::Dispatcher::Handler;

sub handler {
    return (new MMind::Dispatcher::Handler @_)->status;
}

1;
