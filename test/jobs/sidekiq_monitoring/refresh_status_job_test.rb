require 'test_helper'

module SidekiqMonitoring
  class RefreshStatusJobTest < ActiveJob::TestCase
    setup do
      Timecop.travel(DateTime.new(2018, 1, 22))
    end

    teardown do
      Timecop.return
    end

    test 'job' do
      connection = Minitest::Mock.new
      connection.expect(:set, true, ['monitoring:timestamp:sidekiq_performed', '2018-01-22 01:00:00'])
      Redis.stub(:current, connection) do
        RefreshStatusJob.perform_now
      end
    end
  end
end
