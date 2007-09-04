
package POD2::Base;

use 5.005;
use strict;
use warnings;

use vars qw($VERSION);
$VERSION = '0.03';

sub new {
    my $proto = shift;
    my $class = ref $proto || $proto;
    my $obj = bless {}, $class;
    return $obj->_init(@_);
}

# instance variables:
#   lang - the preferred language of the POD documents
#   base_dir - the base directory where these PODs live

sub _init {
    my $self = shift;
    my %args = @_ ? %{$_[0]} : ();
    if ( !exists $args{lang} ) {
        $args{lang} = _extract_lang( ref $self );
    }
    #croak "???" unless $args{lang};
    my $lang = uc $args{lang};
    $self->{lang} = $lang;
    $self->{base_dir} = [ _base_dir($lang) ];

    return $self;
}

# $lang = _extract_lang($module);
sub _extract_lang {
    my $module = shift;

    return $module eq __PACKAGE__  ? undef
         : $module =~ /::(\w+)\z/  ? $1
         :                           undef
         ;
}

sub _base_dir {
    my $lang = shift;

    my $dir = $INC{'POD2/Base.pm'};
    $dir =~ s/Base\.pm\z//;
    $dir .= $lang . '/';
    return $dir;

}

sub pod_dirs {
    my $self = shift;
    return @{ $self->{base_dir} };

}

#sub search_perlfunc_re {
#    shift;
#    return 'Alphabetical Listing of Perl Functions';
#}

sub pod_info {
    shift;
    return {};
}

sub print_pods {
    my $self = shift;
    $self->print_pod(sort keys %{$self->pod_info});
}

sub print_pod {
    my $self = shift;
    my @args = @_ ? @_ : @ARGV;

    my $pods = $self->pod_info;
    while (@args) {
        (my $pod = lc(shift @args)) =~ s/\.pod$//;
        if ( exists $pods->{$pod} ) {
            print "\t'$pod' translated from Perl $pods->{$pod}\n";
        }
        else {
            print "\t'$pod' doesn't yet exists\n";
        }
    }
}

1;


