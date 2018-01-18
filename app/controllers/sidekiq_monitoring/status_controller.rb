require 'redis'
require 'sidekiq'

module SidekiqMonitoring
  class StatusController < ApplicationController
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
        whenever_ran: redis.get('monitoring:timestamp:whenever_ran'),
        sidekiq_performed: redis.get('monitoring:timestamp:sidekiq_performed'),
        requested: Time.now.to_s(:db)
      }
    end

    def sidekiq_data
      {
        active_workers: sidekiq_stats.workers_size,
        queue_sizes: sidekiq_queue_sizes,
        recent_history: {
          processed: sidekiq_history.processed,
          failed: sidekiq_history.failed
        },
        totals: {
          processed: sidekiq_stats.processed,
          failed: sidekiq_stats.failed
        }
      }
    end

    def sidekiq_stats
      @sidekiq_stats ||= Sidekiq::Stats.new
    end

    def sidekiq_history
      @sidekiq_history ||= Sidekiq::Stats::History.new(5)
    end

    def sidekiq_queue_sizes
      queue_sizes = sidekiq_stats.queues

      queue_sizes.merge({
        scheduled: sidekiq_stats.scheduled_size,
        retries: sidekiq_stats.retry_size,
        dead: sidekiq_stats.dead_size
      })
    end

    def redis
      return @redis if @redis.present?
      if SidekiqMonitoring.redis_url.present?
        @redis = Redis.new(url: SidekiqMonitoring.redis_url)
      else
        @redis = Redis.new
      end
      @redis
    end
  end
end
