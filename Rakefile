require 'rake/gempackagetask'

PKG_FILES = FileList[
  '[a-zA-Z]*',
  'generators/**/*',
  'lib/**/*',
  'rails/**/*',
  'tasks/**/*',
  'test/**/*'
]

spec = Gem::Specification.new do |s|
  s.name = "expiry_control"
  s.version = "0.0.1"
  s.author = "Urban Hafner"
  s.email = "urban@bettong.net"
  s.homepage = "http://github.com/msales/expiry_control"
  s.platform = Gem::Platform::RUBY
  s.summary = "DSL to set expires headers for Rails apps"
  s.files = PKG_FILES.to_a
  s.require_path = "lib"

  s.has_rdoc = false
  s.extra_rdoc_files = ["README.md"]
end

desc 'Turn this plugin into a gem.'
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end
