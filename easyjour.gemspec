# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{easyjour}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Elijah Miller"]
  s.date = %q{2008-12-06}
  s.description = %q{Super simple access to service announcing and discovery using Bonjour aka DNSSD.}
  s.email = %q{elijah.miller@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "lib/easyjour/version.rb", "lib/easyjour.rb", "LICENSE", "README"]
  s.files = ["CHANGELOG", "examples/httpjour.rb", "lib/easyjour/version.rb", "lib/easyjour.rb", "LICENSE", "Manifest", "Rakefile", "README", "spec/spec_helper.rb", "easyjour.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://easyjour.rubyforge.org}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Easyjour", "--main", "README"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{easyjour}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Super simple access to service announcing and discovery using Bonjour aka DNSSD.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<echoe>, [">= 0"])
    else
      s.add_dependency(%q<echoe>, [">= 0"])
    end
  else
    s.add_dependency(%q<echoe>, [">= 0"])
  end
end
