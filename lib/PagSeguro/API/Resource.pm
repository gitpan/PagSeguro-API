package PagSeguro::API::Resource;
use strict;
use warnings;

sub new {
    my $class = shift;
    return bless {
        _config => {
            BASE_URI    => 'https://ws.pagseguro.uol.com.br',
            SANDBOX_URI => 'https://ws.sandbox.pagseguro.uol.com.br',
            CHECKOUT    => '/v2/checkout/',
            CHECKOUT_PAYMENT =>
                'https://pagseguro.uol.com.br/v2/checkout/payment.html',
            SANDBOX_CHECKOUT_PAYMENT =>
                'https://sandbox.pagseguro.uol.com.br/v2/checkout/payment.html',
            TRANSACTION   => '/v2/transactions/',
            ABANDONED     => 'abandoned',
            NOTIFICATIONS => 'notifications/',

            }
    }, $class || ref $class;
}

# methods
sub get {
    my ($self, $code) = @_;
    return $self->{_config}->{$code};
}

1;
__END__

=encoding utf8

=head1 NAME

PagSeguro::API::Resource - PagSeguro API class for getting end-point fragments

=head1 SYNOPSIS

    use PagSeguro::API::Resource;

    my $r = PagSeguro::API::Resource->new;
    my $uri_keys = $r->get_keys;

    say $r->get('BASE_URI');

=head1 DESCRIPTION

L<PagSeguro::API::Resource> is a class that store all end-points and some
other informations.

=head1 METHODS

All class methods of public api..

=head2 get

    my $r = PagSeguro::API::Resource->new;
    say $r->get('BASE_URI');

Return value associated to a specific key.

=head2 get_keys

    my $r = PagSeguro::API::Resource->new;
    my $keys = $r->get_keys;

    say "key: $_" for @$keys;
    
Return an C<arrayref> of all keys that you can use.

=head1 AUTHOR

Daniel Vinciguerra <daniel.vinciguerra@bivee.com.br>

2013 (c) Bivee L<http://bivee.com.br>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Bivee.

This is a free software; you can redistribute it and/or modify it under the same terms of Perl 5 programming 
languagem system itself.

