use v6;

unit class Module::Pod;
# Some code based on https://github.com/perl6/doc/blob/master/lib/Pod/Convenience.pm6#L116-L132

use nqp;
use Module::Loader;

has Module::Loader $.loader is required;

has $!precomp-handle;
method precomp-handle {
    $!precomp-handle //=
        $.loader.compunit.repo.need($.loader.spec).handle;
}

method pod {
    nqp::atkey($.precomp-handle.unit, <$=pod>);
}

sub pod-from-module(Module::Loader::ModuleName $module) is export {
    my $loader = Module::Loader.new(module => $module);
    Module::Pod.new(loader => $loader).pod;
}

=begin SYNOPSIS

=begin code

use Module::Loader;
use Module::Pod;

my $l = Module::Loader.new(module => <Seq::Bounded>);
say describe-compunit($l.compunit);
say Module::Pod.new(:loader($l)).pod

=end code

=end SYNOPSIS
