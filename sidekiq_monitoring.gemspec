$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sidekiq_monitoring/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sidekiq_monitoring"
  s.version     = SidekiqMonitoring::VERSION
  s.authors     = ["Julian Dobmann"]
  s.email       = ["julian@bitcrowd.net"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SidekiqMonitoring."
  s.description = "TODO: Description of SidekiqMonitoring."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "sqlite3"
end
