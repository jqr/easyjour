require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require "lib/easyjour/version"

require 'echoe'
Echoe.new 'easyjour', Easyjour::Version do |p|
  p.description     = "Super simple access to service announcing and discovery using Bonjour aka DNSSD."
  p.url             = "http://easyjour.rubyforge.org"
  p.author          = "Elijah Miller"
  p.email           = "elijah.miller@gmail.com"
  # p.extra_deps      = [['net-mdns', '>= 0.4']]
  p.need_tar_gz     = false
end


Rake::Task[:default].prerequisites.clear
desc 'Default: run specs'
task :default => :spec
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList["spec/**/*_spec.rb"]
end
