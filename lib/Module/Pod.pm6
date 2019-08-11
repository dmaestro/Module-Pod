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
sub pod-from-module(Module::Loader::ModuleName $module) is export {
    my $loader = Module::Loader.new(module => $module);
    Module::Pod.new(loader => $loader).pod;
}

=LICENSE This file is licensed under the same terms as perl itself.

=AUTHOR Doug Schrag <dmaestro@cpan.org>
