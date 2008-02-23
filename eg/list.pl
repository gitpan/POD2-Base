

use strict;
use warnings;

die "usage: $0 lang" unless @ARGV;
my $lang = uc shift;

use File::Find;
use POD2::Base;

my $pod2 = POD2::Base->new({ lang => $lang });

my @dirs = $pod2->pod_dirs;
die "could not find any POD2/${lang}/ directory" unless @dirs;
print "dirs: @dirs.\n";
my @files;
find({
        wanted => sub { push @files, $File::Find::name if -f },
     },
     @dirs );
print "$_\n" for @files;

__END__

=head1 NAME

list.pl - find all POD dirs for a language

=head1 USAGE

    list.pl lang

where B<lang> is the apropriate language code 
(eg. PT, IT, FR, etc.)

