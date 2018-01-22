module SidekiqMonitoring
  class Status
    def self.refresh
      Redis.current.set('monitoring:timestamp:whenever_ran', Time.now.strftime('%Y-%m-%d %H:%M:%S'))
      RefreshStatusJob.perform_later
    end
  end
end
