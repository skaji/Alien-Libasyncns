package MyAlienBuild;

use Moose;
use List::Util 'first';
extends 'Dist::Zilla::Plugin::AlienBuild';

my $os_unsupported = <<'___';
# http://0pointer.de/lennart/projects/libasyncns/ says
# "Currently, libasyncns is tested on Linux and Solaris (sparc-sun-solaris2.8) only."
if ($^O !~ /^(?:linux|solaris)$/ and !$ENV{PERL_ALIEN_LIBASYNCNS_FORCE}) {
    die "OS unsupported\n";
}
___

after munge_files => sub {
    my $self = shift;
    my $file = first { $_->name eq 'Makefile.PL' } @{ $self->zilla->files };
    my $content = $file->content;
    $content =~ s/^(use ExtUtils::MakeMaker.*)/$1\n\n$os_unsupported/m or die;
    $file->content($content);
};

__PACKAGE__->meta->make_immutable;

1;
