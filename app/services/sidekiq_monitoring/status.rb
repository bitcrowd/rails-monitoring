module SidekiqMonitoring
  class Status
    def self.refresh
      SidekiqMonitoring.redis.set('monitoring:timestamp:whenever_ran', Time.current.strftime('%Y-%m-%d %H:%M:%S'))
      RefreshStatusJob.perform_later
    end
  end
end
