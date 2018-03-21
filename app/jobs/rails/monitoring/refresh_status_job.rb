module Rails
  module Monitoring
    class RefreshStatusJob < ApplicationJob
      def perform
        Sidekiq.redis do |conn|
          conn.set('monitoring:timestamp:sidekiq_performed', Time.current.to_formatted_s(:iso8601))
        end
      end
    end
  end
end
