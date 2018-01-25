module SidekiqMonitoring
  class RefreshStatusJob < ApplicationJob
    def perform
      Redis.current.set('monitoring:timestamp:sidekiq_performed', Time.current.to_s(:db))
    end
  end
end
