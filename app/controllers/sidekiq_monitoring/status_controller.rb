module SidekiqMonitoring
  class StatusController < ApplicationController
    http_basic_authenticate_with name:     SidekiqMonitoring.http_auth_name,
                                 password: SidekiqMonitoring.http_auth_password

    def status
      render json: status_data
    end

    private

    def status_data
      {
        timestamps: timestamps,
        sidekiq: sidekiq_data
      }
    end

    def timestamps
      {
        whenever_ran: redis_get('monitoring:timestamp:whenever_ran'),
        sidekiq_performed: redis_get('monitoring:timestamp:sidekiq_performed'),
        requested: Time.current.to_s(:db)
      }
    end

    def redis_get(key)
      Sidekiq.redis do |conn|
        conn.get(key)
      end
    end

    def sidekiq_data
      {
        active_workers: sidekiq_stats.workers_size,
        queue_sizes: sidekiq_queue_sizes,
        recent_history: recent_history,
        totals: totals
      }
    end

    def sidekiq_stats
      @sidekiq_stats ||= Sidekiq::Stats.new
    end

    def sidekiq_history
      @sidekiq_history ||= Sidekiq::Stats::History.new(5)
    end

    def recent_history
      {
        processed: sidekiq_history.processed,
        failed: sidekiq_history.failed
      }
    end

    def totals
      {
        processed: sidekiq_stats.processed,
        failed: sidekiq_stats.failed
      }
    end

    def sidekiq_queue_sizes
      queue_sizes = sidekiq_stats.queues

      queue_sizes.merge(
        scheduled: sidekiq_stats.scheduled_size,
        retries: sidekiq_stats.retry_size,
        dead: sidekiq_stats.dead_size
      )
    end
  end
end
