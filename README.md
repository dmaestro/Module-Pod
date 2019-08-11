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
) returns Mu
```

Get the $=pod from the named module

LICENSE
=======

This file is licensed under the same terms as perl itself.

AUTHOR
======

Doug Schrag <dmaestro@cpan.org>

