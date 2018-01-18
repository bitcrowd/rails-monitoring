require "sidekiq_monitoring/engine"

module SidekiqMonitoring
  mattr_accessor :redis_url
  @@redis_url = 'redis://localhost:6379/0'
end
