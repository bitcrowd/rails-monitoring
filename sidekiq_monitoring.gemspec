$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sidekiq_monitoring/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sidekiq_monitoring"
  s.version     = SidekiqMonitoring::VERSION
  s.authors     = ["Julian Dobmann"]
  s.email       = ["julian@bitcrowd.net"]
  s.homepage    = "https://github.com/bitcrowd/sidekiq-monitoring"
  s.summary     = "Provide Sidekiq status information via JSON API."
  s.description = <<~EOS
                  Rails engine that provides a JSON API which serves Sidekiq
                  status information from a HTTP-auth protected endpoint.
                  This status information is gathered by scheduling a frequently
                  running job that saves timestamps in Redis.
  EOS
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2"
  s.add_dependency "redis"
  s.add_dependency "sidekiq"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "timecop"
  s.add_development_dependency "fakeredis"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "rubocop-bitcrowd"
end
