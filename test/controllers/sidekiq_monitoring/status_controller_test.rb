require 'test_helper'

module SidekiqMonitoring
  class StatusControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
      Timecop.travel(DateTime.new(2018, 1, 22))
    end

    teardown do
      Timecop.return
    end

    test 'response' do
      connection = Minitest::Mock.new
      connection.expect(:get, 'whenever-timestamp', ['monitoring:timestamp:whenever_ran'])
      connection.expect(:get, 'sidekiq-timestamp', ['monitoring:timestamp:sidekiq_performed'])

      Redis.stub(:current, connection) do
        get status_url
      end

      body = JSON.parse response.body
      expected_timestamps = {
        whenever_ran: 'whenever-timestamp',
        sidekiq_performed: 'sidekiq-timestamp',
        requested: '2018-01-22 01:00:00'
      }.stringify_keys
      assert_equal expected_timestamps, body['timestamps']

      expected_sidekiq = {}
      assert_equal expected_sidekiq, body['sidekiq']
    end

    # test 'response with previously run service' do
    #   get status_url
    #   body = JSON.parse response.body
    # end
    #
    # test 'response with previously run job' do
    #   get status_url
    #   body = JSON.parse response.body
    # end
  end
end
