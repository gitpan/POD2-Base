
use 5;
use ExtUtils::MakeMaker;

my $EUMM_VERSION = eval $ExtUtils::MakeMaker::VERSION;

WriteMakefile(
    NAME              => 'POD2::Base',
    VERSION_FROM      => 'lib/POD2/Base.pm',
    PREREQ_PM         => {
        strict            => 0,
      ( warnings::compat  => 0, ) x!! ( $] < 5.006 ),

        Test::More        => 0,
    },
    ($] >= 5.005 ? (
        'ABSTRACT_FROM' => 'lib/POD2/Base.pod',
#        'AUTHOR'        => 'Adriano R. Ferreira <ferreira@cpan.org>',
    ) : ()),
    ($EUMM_VERSION >= 6.31 ? (
        LICENSE => 'perl', 
        EXTRA_META => "recommends:\n" .
                      "    Test::Pod:                     1.18\n" .
                      "    Test::Pod::Coverage:           1.04\n" 
    ) :())

);
