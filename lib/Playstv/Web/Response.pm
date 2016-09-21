package Playstv::Web::Response;

use Mouse;
use JSON;

has response => (
    is       => 'rw',
    isa      => 'HTTP::Response',
    required => 1,
);

has as_string => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        my $self = shift;
        return $self->response->content;
    },
);

has as_json => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        my $self = shift;
        my $response = $self->response;
        if ($response->is_success) {
            return $response->content;
        } else {
            my $message = $response->message;
            my $error = eval { JSON->new->decode($response->content) };
            unless ($@) {
                $message->{error}{type} . ' - ' . $error->{error}{message};
            }
        }
    },
);

has as_hashref => (
    is      => 'ro',
    lazy    => 1,
    default => sub {
        my $self = shift;
        return JSON->new->decode($self->as_json);
    },
);

1;

=head1 NAME

Playstv::Web::Response - Handling of a Playstv::Web response documents.

=head1 DESCRIPTION

You'll given result if you call C<request> method on a <Playstv::Web::Query>.

=head1 METHODS

Returns the response as a string.

=head2 as_json ()

Returns the response from Plays.tv as a JSON String.

=head2 as_hashref ()

Returns the response from Plays.tv as a hash reference.

=head2 as_string ()

Returns the raw body string that was received from Plays.tv.

=head2 response ()

Direct access to the L<HTTP::Response> object.

=head1 AUTHORS

Daiki Wakasa

