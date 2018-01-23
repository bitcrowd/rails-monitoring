require "sidekiq_monitoring/engine"

module SidekiqMonitoring
  mattr_accessor :http_auth_name
  mattr_accessor :http_auth_password
end
