$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'rails/monitoring/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'rails-monitoring'
  s.version     = Rails::Monitoring::VERSION
  s.authors     = ['Julian Dobmann']
  s.email       = ['julian@bitcrowd.net']
  s.homepage    = 'https://github.com/bitcrowd/rails-monitoring'
  s.summary     = 'Provide Rails status information via JSON API.'
  s.description = <<~TEXT
    Rails engine that provides a JSON API which serves Sidekiq and Whenever
    status information from a HTTP-auth protected endpoint.
    This status information is gathered by scheduling a frequently
    running job that saves timestamps in Redis.
  TEXT
  s.license = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 5.2'
  s.add_dependency 'sidekiq'

  s.add_development_dependency 'fakeredis'
  s.add_development_dependency 'minitest-around'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-bitcrowd'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'timecop'
end
