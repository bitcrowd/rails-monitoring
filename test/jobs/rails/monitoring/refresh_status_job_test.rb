require 'test_helper'

module Rails
  module Monitoring
    class RefreshStatusJobTest < ActiveJob::TestCase
      setup do
        Timecop.freeze(Date.new(2018, 1, 22))
      end

      teardown do
        Timecop.return
      end

      def around
        TestHelper.stub_redis { yield }
      end

      test 'job sets timestamp in redis' do
        fakeredis = Redis.new
        assert_nil fakeredis.get('monitoring:timestamp:sidekiq_performed')

        RefreshStatusJob.perform_now

        assert_equal '2018-01-22 00:00:00', fakeredis.get('monitoring:timestamp:sidekiq_performed')
      end
    end
  end
end
