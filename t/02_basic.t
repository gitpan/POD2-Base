
use Test::More tests => 11;

BEGIN { use_ok( 'POD2::Base' ); }

{
my $pod2 = POD2::Base->new({ lang => 'tlh' });
isa_ok( $pod2, 'POD2::Base' );

is( $pod2->{lang}, 'TLH' );

my @dirs = $pod2->pod_dirs;
is( @dirs, 1 );
like( $dirs[0], '/POD2\/TLH\/$/' );

}

package POD2::TLH;

our @ISA = qw( POD2::Base );

sub search_perlfunc_re {
    return 'Klingon Listing of Functions';
}

package main;

{
my $pod2 = POD2::TLH->new;
isa_ok( $pod2, 'POD2::TLH' );
isa_ok( $pod2, 'POD2::Base' );

is( $pod2->{lang}, 'TLH' );

my @dirs = $pod2->pod_dirs;
is( @dirs, 1 );
like( $dirs[0], '/POD2\/TLH\/$/' );

is( $pod2->search_perlfunc_re, 'Klingon Listing of Functions' );

}