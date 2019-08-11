use v6;
unit class Module::Pod;
# Some code based on https://github.com/perl6/doc/blob/master/lib/Pod/Convenience.pm6#L116-L132

=begin pod

=NAME Module::Pod

=begin SYNOPSIS

=begin code :test
use Module::Loader;
use Module::Pod;

my $l = Module::Loader.new(module => <Seq::Bounded>);
say describe-compunit($l.compunit);
say Module::Pod.new(:loader($l)).pod
=end code

=begin code :test
use Module::Pod;

my $pod1 = pod-from-module(Module::Loader);
=end code

=end SYNOPSIS

=begin DESCRIPTION

This module is able to load external Perl 6 modules and provide the
documentation object from its C<$=pod> variable. This allows, for example,
running tests against the documentation, without requiring special hooks in the
external module to expose that variable.

C<Module::Pod> exports a helper function, C<pod-from-module()>, which accepts
either a string (short-name) or a type object specifying the external module
desired. It returns a <Positional> containing C<Pod::Block> objects, exactly
as C<$=pod> does within it's own compilation unit.

=end DESCRIPTION

=end pod

use nqp;
use Module::Loader;

=begin ATTRIBUTES

=item C<loader> - An object of type Module::Loader, specifying
the external module

=end ATTRIBUTES

has Module::Loader $.loader is required;

has $!precomp-handle;
method precomp-handle {
    $!precomp-handle //=
        $.loader.compunit.repo.need($.loader.spec).handle;
}

=METHODS

#| Return the $=pod from the module,
#| precompiling if necessary
method pod() {
    nqp::atkey($.precomp-handle.unit, <$=pod>);
}

=EXPORTS

#| Get the $=pod from the named module
sub pod-from-module(Module::Loader::ModuleName $module)
        returns Positional
        is export
{
    my $loader = Module::Loader.new(module => $module);
    Module::Pod.new(loader => $loader).pod;
}

=LICENSE This file is licensed under the same terms as perl itself.

=AUTHOR Doug Schrag <dmaestro@cpan.org>
