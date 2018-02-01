require 'test_helper'

module SidekiqMonitoring
  class SidekiqMonitoringTest < ActiveSupport::TestCase
    include ActiveJob::TestHelper

    test 'calls Redis.new when redis_url is configured' do
      SidekiqMonitoring.redis_url = 'redis://127.0.0.1:6379/0'
      connection = Object.new

      Redis.stub(:new, connection) do
        assert_equal connection, SidekiqMonitoring.redis
      end
    end

    test 'calls Redis.current when redis_url is not configured' do
      SidekiqMonitoring.redis_url = nil
      connection = Object.new

      Redis.stub(:current, connection) do
        assert_equal connection, SidekiqMonitoring.redis
      end
    end
  end
end
