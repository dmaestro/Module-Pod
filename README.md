NAME
====

Module::Pod

SYNOPSIS
========

    use Module::Loader;
    use Module::Pod;

    my $l = Module::Loader.new(module => <Seq::Bounded>);
    say describe-compunit($l.compunit);
    say Module::Pod.new(:loader($l)).pod

    use Module::Pod;

    my $pod1 = pod-from-module(Module::Loader);

DESCRIPTION
===========

This module is able to load external Perl 6 modules and provide the documentation object from its `$=pod` variable. This allows, for example, running tests against the documentation, without requiring special hooks in the external module to expose that variable.

`Module::Pod` exports a helper function, `pod-from-module()`, which accepts either a string (short-name) or a type object specifying the external module desired. It returns a <Positional> containing `Pod::Block` objects, exactly as `$=pod` does within it's own compilation unit.

ATTRIBUTES
==========

  * `loader` - An object of type Module::Loader, specifying the external module

METHODS
=======



### method pod

```perl6
method pod() returns Mu
```

Return the $=pod from the module, precompiling if necessary

EXPORTS
=======



### sub pod-from-module

```perl6
sub pod-from-module(
    $module where { ... }
) returns Positional
```

Get the $=pod from the named module

LICENSE
=======

This file is licensed under the same terms as perl itself.

AUTHOR
======

Doug Schrag <dmaestro@cpan.org>

