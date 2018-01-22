require 'test_helper'

module SidekiqMonitoring
  class RefreshStatusJobTest < ActiveJob::TestCase
    test 'job' do
      RefreshStatusJob.perform_now
      assert redis_thing
    end
  end
end
