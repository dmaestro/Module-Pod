use v6;
use Test;

plan 3;

need Module::Pod; # no imports

throws-like { ::('pod-from-module')('Module::Pod') }, X::NoSuchSymbol,
    'function not available with "need"';

lives-ok { Module::Pod.new(loader => Module::Loader); },
    'Class is still available';

{
    use Module::Pod :DEFAULT; # explicitly import, optional

    lives-ok { pod-from-module('Module::Pod') },
    'With import, function is available';
}


