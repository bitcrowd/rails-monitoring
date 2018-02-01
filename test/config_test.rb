require 'test_helper'

module SidekiqMonitoring
  class ConfigTest < ActiveJob::TestCase
    test 'initializer is called and sets values on module' do
      assert_equal 'SomeController', SidekiqMonitoring.parent_controller
      assert_equal 'some_redis_url', SidekiqMonitoring.redis_url
      assert_equal 'some_user',      SidekiqMonitoring.http_auth_name
      assert_equal 'some_password',  SidekiqMonitoring.http_auth_password
    end
  end
end
