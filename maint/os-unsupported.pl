# http://0pointer.de/lennart/projects/libasyncns/ says
# "Currently, libasyncns is tested on Linux and Solaris (sparc-sun-solaris2.8) only."
if ($^O !~ /^(?:linux|solaris)$/ and !$ENV{PERL_ALIEN_LIBASYNCNS_FORCE}) {
    die "OS unsupported\n";
}
