require 'test_helper'

module SidekiqMonitoring
  class StatusTest < ActiveSupport::TestCase
    test "truth" do
      assert_kind_of Module, SidekiqMonitoring
    end
  end
end
