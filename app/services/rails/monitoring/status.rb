module Rails
  module Monitoring
    class Status
      def self.refresh
        Sidekiq.redis do |conn|
          conn.set('monitoring:timestamp:whenever_ran', Time.current.to_formatted_s(:iso8601))
        end
        RefreshStatusJob.perform_later
      end
    end
  end
end
