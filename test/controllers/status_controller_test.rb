require 'test_helper'

module SidekiqMonitoring
  class StatusControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    test 'something' do
      get status_url
    end
  end
end
