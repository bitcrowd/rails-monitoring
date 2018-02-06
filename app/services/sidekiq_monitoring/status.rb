module SidekiqMonitoring
  class Status
    def self.refresh
      Sidekiq.redis do |conn|
        conn.set('monitoring:timestamp:whenever_ran', Time.current.to_s(:db))
      end
      RefreshStatusJob.perform_later
    end
  end
end
