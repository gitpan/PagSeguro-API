
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'PagSeguro::API',
    VERSION_FROM => 'lib/PagSeguro/API.pm',
    AUTHOR    => 'Daniel Vinciguerra (daniel.vinciguerra@bivee.com.br)',
    ABSTRACT  => 'PagSeguro API Client',
    PREREQ_PM => {
        'Test::More'  => 0.98,
        'XML::Simple' => 2.20,
        'LWP::Simple' => 6.00,
        'LWP::UserAgent' => 6.00,
    },
);
