use v6;
unit class Module::Loader;
# Some code based on https://github.com/perl6/doc/blob/master/lib/Pod/Convenience.pm6#L116-L132

has Str                     $.module;
has CompUnit::Repository    $.root-repo = $*REPO;
has                         @!compunits;
has Int                     $.index is rw = 0;

method spec() returns CompUnit::DependencySpecification {
    CompUnit::DependencySpecification.new(short-name => self.module);
}
method available-compunits() returns Iterable {
    @!compunits ||=
        self.root-repo.resolve(self.spec);
}
method multiple() {
    self.available-compunits.elems > 1;
}
method compunit() {
    self.available-compunits[$!index];
}

method file() returns Str {
    my $cu = self.compunit;
    my $name = $cu.short-name;
    my $file-descriptor = $cu.distribution.meta<provides>{ $name };
    if $file-descriptor ~~ Hash {
        my ($file-name, $precomp-descriptor, $more) = $file-descriptor.kv;
        fail("unexpected multiple file descriptors for $name!")
            if $more;
        say "Precomp for: $file-name";
        return 'sources'.IO.add($precomp-descriptor<file>).Str;
    }
    return $file-descriptor;
}

sub describe-compunit(CompUnit $compunit --> Str) is export {
    join IO.nl-out,
        "Name (short-name): $compunit.short-name()",
        "Distribution:      $compunit.distribution()",
        "Repo prefix:       {$compunit.repo.perl}",
        "Is-precompiled:    $compunit.precompiled()",

}

method loadable-file () {
    my $loadable-file = self.compunit.distribution.prefix.add(self.file);
}
