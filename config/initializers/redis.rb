Rails.application.config.after_initialize do
  SidekiqMonitoring.connection = if SidekiqMonitoring.redis_url.present?
                                   Redis.new(url: SidekiqMonitoring.redis_url)
                                 else
                                   Redis.current
                                 end
end
