use v6;

unit class Module::Pod;
# Some code based on https://github.com/perl6/doc/blob/master/lib/Pod/Convenience.pm6#L116-L132

use nqp;

has IO::Path    $.file-handle;
has CompUnit::PrecompilationRepository
                $.precomp is required;

has IO::Path    $!resolved-file;
method file {
    $!resolved-file //=
        $!file-handle.resolve;
}

has Str             $!id;
method id {
    $!id //=
        nqp::sha1($.file.Str);
}

has                 $!precomp-handle;
method precomp-handle {
    $!precomp-handle //=
        $.precomp.load($.id, :since($.file.modified))[0]
        || do { $.precomp.precompile($.file, $.id, :force);
            $!precomp.load($.id)[0];
        }
}

method pod {
    nqp::atkey($.precomp-handle.unit, <$=pod>)[0];
}

=begin SYNOPSIS

=begin code

use Module::Loader;
use Module::Pod;

my $l = Module::Loader.new(module => <Seq::Bounded>);
say describe-compunit($l.compunit);
say Module::Pod.new(:file-handle($l.loadable-file), :precomp($l.precomp)).pod'

=end code

=end SYNOPSIS