package Playstv::Web::Role::Uri;

use Mouse::Role;
use URI;

sub uri {
    return URI->new('https://api.plays.tv/data/');
}

has api_version => (
    is      => 'rw',
    default => 'v1',
);

sub generate_versioned_path {
    my ($self, $path) = @_;
    return join('/', $self->api_version, $path);
}

1;
