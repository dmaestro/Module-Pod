use v6;

use Test;

use Module::Pod;

plan 2;

my $pod = pod-from-module('Module::Loader');

is $pod.elems, 1,
    'One top-level pod block';

isa-ok $pod[0], Pod::Block,
    'type Pod::Block';
