require 'sidekiq_monitoring_bitcrowd/engine'

module SidekiqMonitoring
  mattr_accessor :parent_controller
  self.parent_controller = '::ApplicationController'

  mattr_accessor :redis_url
  self.redis_url = 'redis://127.0.0.1:6379/0'

  mattr_accessor :http_auth_name
  mattr_accessor :http_auth_password

  def self.redis
    if SidekiqMonitoring.redis_url.present?
      Redis.new(url: SidekiqMonitoring.redis_url)
    else
      Redis.current
    end
  end
end
