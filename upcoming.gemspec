$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'upcoming/version'

Gem::Specification.new do |s|
  s.name        = 'upcoming'
  s.version     = Upcoming::VERSION
  s.licenses    = ['MIT']
  s.summary     = 'Recurring date generator'
  s.description = 'Generate recurring dates based on slightly more complex rules than usual (eg. last working day every month)'
  s.authors     = ['David Lantos']
  s.email       = ['david.lantos@gmail.com']
  s.homepage    = 'https://github.com/sldblog/upcoming'

  s.required_ruby_version = '>= 2.0'

  s.add_dependency 'activesupport', '~> 4.1'
  %w(rake minitest-given).each do |d|
    s.add_development_dependency d
  end

  s.files         = Dir['Rakefile', '{bin,lib,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  s.test_files    = s.files.grep %r{^(spec)/}
  s.require_paths = ['lib']
end
