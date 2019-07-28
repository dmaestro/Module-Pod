use v6;
unit class Module::Loader;

subset ModuleName of Any where Any:U | Cool;
has ModuleName              $.module;
has CompUnit::Repository    $.root-repo = $*REPO;
has                         @!compunits;
has Int                     $.index is rw = 0;

method module-name() returns Str {
    $.module // $.module.^name;
}
method spec() returns CompUnit::DependencySpecification {
    CompUnit::DependencySpecification.new(short-name => $.module-name);
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

sub describe-compunit(CompUnit $compunit --> Str) is export {
    join IO.nl-out,
        "Name (short-name): $compunit.short-name()",
        "Distribution:      $compunit.distribution()",
        "Repo prefix:       {$compunit.repo.perl}",
        "Is-precompiled:    $compunit.precompiled()",
}
