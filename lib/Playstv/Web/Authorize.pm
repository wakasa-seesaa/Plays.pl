package Playstv::Web::Authorize;

use Mouse;
with 'Playstv::Web::Role::Uri';

has app_id => (
    is       => 'ro',
    required => 1,
);

has api_key => (
    is       => 'ro',
    required => 1,
);

#has token => (
#    is => 'ro',
#    required => 0,
#    predicate => has_token,
#);

sub uri_as_string {
    my ($self) = @_;
    my $uri = $self->uri;
    $uri->path('auth/verify');
    my %query = (
        appid  => $self->app_id,
        apikey => $self->api_key,
    );
    $uri->query_form(%query);
    return $uri->as_string;
}

1;
