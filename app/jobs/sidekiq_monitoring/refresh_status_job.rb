module SidekiqMonitoring
  class RefreshStatusJob < ApplicationJob
    def perform
      SidekiqMonitoring.redis.set('monitoring:timestamp:sidekiq_performed', Time.current.to_s(:db))
    end
  end
end
