require "sidekiq_monitoring/engine"

module SidekiqMonitoring
  mattr_accessor :redis_url
  @@redis_url = 'redis://127.0.0.1:6379/0'

  mattr_accessor :http_auth_name
  mattr_accessor :http_auth_password
end
