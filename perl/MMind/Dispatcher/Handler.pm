package MMind::Dispatcher::Handler;

use strict;
use warnings;

use Apache2::Const qw(
    OK NOT_FOUND FORBIDDEN HTTP_METHOD_NOT_ALLOWED SERVER_ERROR
);
use Apache2::RequestUtil;
use Apache2::RequestIO;
use APR::Const qw(SUCCESS);

use MMind::Dispatcher::Endpoints qw(uri2pkg);

sub status {
    my $self = shift;
    return @_ ? ($self->{status} = shift) : $self->{status};
}

sub new {
    my $class = shift;
    bless my $self = {};

    my $r = shift;

    my ($uri, $docroot, $method) = ($r->uri, $r->document_root, $r->method);

    if (my $pkg = uri2pkg $uri) {
        new $pkg $r;
        $self->status (OK);
    }
    elsif ($method eq 'GET') {
        my $path = "$docroot/$uri";

        if (-f $path) {
            if ($r->sendfile ($path) == SUCCESS) {
                $self->status (OK);
            }
            else {
                $self->status (SERVER_ERROR);
            }
        }
        elsif (-e $path) {
            $self->status (FORBIDDEN);
        }
        else {
            $self->status (NOT_FOUND);
        }
    }
    else {
        $self->status (HTTP_METHOD_NOT_ALLOWED);
    }

    return $self;
}

1;
