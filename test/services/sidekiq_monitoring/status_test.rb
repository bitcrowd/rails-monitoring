require 'test_helper'

module SidekiqMonitoring
  class StatusTest < ActiveSupport::TestCase
    include ActiveJob::TestHelper

    setup do
      Timecop.freeze(Date.new(2018, 1, 22))
    end

    teardown do
      Timecop.return
    end

    def around
      TestHelper.stub_redis { yield }
    end

    test 'writes timestamp to redis and schedules job' do
      fakeredis = Redis.new
      assert_nil fakeredis.get('monitoring:timestamp:whenever_ran')

      assert_enqueued_with(job: RefreshStatusJob) do
        Status.refresh

        assert_equal '2018-01-22 00:00:00', fakeredis.get('monitoring:timestamp:whenever_ran')
      end
    end
  end
end
