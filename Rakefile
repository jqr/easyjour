project_name = 'easyjour'
website_path = "jqr@rubyforge.org:/var/www/gforge-projects/#{project_name}"

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require "lib/#{project_name}/version"

require 'echoe'
Echoe.new project_name, Easyjour::Version do |p|
  p.description     = "Super simple access to service announcing and discovery using Bonjour aka DNSSD."
  p.url             = "http://#{project_name}.rubyforge.org"
  p.author          = "Elijah Miller"
  p.email           = "elijah.miller@gmail.com"
  # p.extra_deps      = [['gem', '>= version']]
  p.need_tar_gz     = false
  p.docs_host       = website_path
end


Rake::Task[:default].prerequisites.clear
desc 'Default: run specs'
task :default => :spec
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList["spec/**/*_spec.rb"]
end


desc 'Generate documentation for the scoped_associations plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ScopedAssociations'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


desc 'Upload website files to rubyforge'
task :website do
  sh %{rsync -av website/ #{WebsitePath}}
  Rake::Task['website_docs'].invoke
end

task :website_docs do
  Rake::Task['redocs'].invoke
  sh %{rsync -av doc/ #{WebsitePath}/docs}
end

desc 'Preps the gem for a new release'
task :prepare do
  %w[manifest build_gemspec].each do |task|
    Rake::Task[task].invoke
  end
end

