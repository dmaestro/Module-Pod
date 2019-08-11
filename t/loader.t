use v6;
use Test;

use Module::Loader;

my $loader = Module::Loader.new(module => Module::Loader);

plan 5;

is $loader.spec.short-name, 'Module::Loader',
    'Provides spec';

is $loader.available-compunits.elems, 1,
    'One compunit loaded';

nok $loader.multiple,
    'Only one version available';

ok $loader.compunit.defined,
    'CompUnit present (not undefined)';

isa-ok $loader.compunit, CompUnit,
    'Loaded a CompUnit';
