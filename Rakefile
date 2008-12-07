require 'spec/rake/spectask'

require 'echoe'
Echoe.new 'easyjour' do |p|
  p.description     = "Super simple access to service announcing and discovery using Bonjour aka DNSSD."
  p.url             = "http://easyjour.rubyforge.org"
  p.author          = "Elijah Miller"
  p.email           = "elijah.miller@gmail.com"
  p.retain_gemspec  = true
  p.need_tar_gz     = false
  p.extra_deps      = [
    ['dnssd', '>= 0.7.0']
  ]
end

desc 'Default: run specs'
task :default => :spec
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList["spec/**/*_spec.rb"]
end

task :test => :spec
