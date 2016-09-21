package Playstv::Web::Request;

use Mouse;
use JSON;
use LWP::UserAgent;
use LWP::Protocol::https;
use Playstv::Web::Response;

has ua => (
    is => 'rw',
    isa => 'LWP::UserAgent',
    lazy => 1,
    default => sub {
        my $ua = LWP::UserAgent->new;
        $ua->timeout(30);
        return $ua;
    },
);

sub post {
    my ($self, $uri, $params) = @_;
    return Playstv::Web::Response->new(response => $self->ua->post($uri, @params));
}

sub get {
    my ($self, $uri) = @_;
    return Playstv::Web::Response->new(response => $self->ua->get($uri));
}

1;
