package PagSeguro::API::Checkout;
use base 'PagSeguro::API::Base';

use Carp;
use Try::Tiny;
use XML::Simple;

# constructor
sub new {
    my $class = shift;
    my $args = (@_ % 2 == 0)? {@_} : shift;

    return bless {
        _code        => undef,
        _context => ($args->{context})? $args->{context} : $args,
        _transaction => undef,
    }, $class;
}

# accessors
sub _context {
    return $_[0]->{_context} if $_[0]->{_context};
}
sub code {
    return $_[0]->{_code} if $_[0]->{_code};
}

# methods
sub send {
    my $self = shift;
    my $args = (@_ % 2 == 0) ? {@_} : undef;

    $self->{_code} = undef;

    if ($args) {

        # parse and return by file
        return XMLin( $args->{file} ) if $args->{file};

        $args->{email}        = $self->_context->email;
        $args->{token}        = $self->_context->token;
        $args->{currency}     = $args->{currency}     || 'BRL';
        $args->{shippingType} = $args->{shippingType} || '3';

        # getting response
        my $uri = $self->_checkout_uri( $args );
        my $response = $self->post( $uri, $args );

        # debug
        warn "[Debug] Checkout Response: $response\n"
          if $ENV{PAGSEGURO_API_DEBUG};

        my $xml = XMLin($response);

        $self->{_code} = $xml->{code} if $xml->{code};
        return $xml;
    }
    else {
        # error
        croak "Error: invalid paramether bound";
    }
}

sub payment_url {
    my ($self, $code) = @_;

    $code = $self->code unless $code;
    
    my $uri = join '',
        (
        $self->_context->resource($ENV{PAGSEGURO_API_SANDBOX}
            ? 'SANDBOX_CHECKOUT_PAYMENT'
            : 'CHECKOUT_PAYMENT'),
        "?code=", $code
        );

    warn "[Debug] URI: $uri\n" if $ENV{PAGSEGURO_API_DEBUG};
    return $uri;
}

sub _checkout_uri {
    my ( $self, $args ) = @_;

    # add email and token
    $args->{email} = $args->{email} || $self->_context->email;
    $args->{token} = $args->{token} || $self->_context->token;

    # build query string
    my $query_string = join '&', map { "$_=$args->{$_}" } keys %$args;

    my $uri = join '',
      (
        $self->_context->resource(
            ( $ENV{PAGSEGURO_API_SANDBOX} ? 'SANDBOX_URI' : 'BASE_URI' )
        ),
        $self->_context->resource('CHECKOUT'),
        "?",
        $query_string
      );

    warn "[Debug] URI: $uri\n" if $ENV{PAGSEGURO_API_DEBUG};
    return $uri;
}

1;
