use v6;
use Test;

use Module::Pod;

plan 5;

my $pod = Module::Pod.new(loader => Module::Loader.new( module => 'Module::Loader' ));

isa-ok $pod, Module::Pod,
    'created object';

isa-ok $pod.loader, Module::Loader,
    'loader is instantiated';

my $loader-pod = $pod.pod;

is $loader-pod.elems, 1,
    'one top-level pod block';

isa-ok $loader-pod[0], Pod::Block,
    'type Pod::Block';

ok $loader-pod[0].all ~~ Pod::Block::Named,
    'all second-level pod blocks are Named';
