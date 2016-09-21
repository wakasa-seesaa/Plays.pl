package Playstv::Web::AccessToken::Response;

use Mouse;
use URI;
use URI::QueryParam;
use JSON;

has response => (
    is       => 'ro',
    required => 1,
);

has is_success => (
    is => 'ro',
    lazy => 1,
    default => sub {
        my $self = shift;
        my $response = $self->response;
        if ($response->is_success) {
            return JSON->new->decode($response->content)->{code}
        }
    }
);
