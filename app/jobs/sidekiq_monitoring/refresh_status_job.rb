module SidekiqMonitoring
  class RefreshStatusJob < ApplicationJob
    def perform
      Redis.current.set('monitoring:timestamp:sidekiq_performed', Time.now.to_s(:db))
    end
  end
end
