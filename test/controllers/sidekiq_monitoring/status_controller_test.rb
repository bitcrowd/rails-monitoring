require 'test_helper'
require 'fakeredis/minitest'

module SidekiqMonitoring
  class StatusControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include ActiveJob::TestHelper

    setup do
      @routes = Engine.routes
      Timecop.freeze(Date.new(2018, 1, 22))
      @auth = ActionController::HttpAuthentication::Basic
              .encode_credentials('user', 'password')
    end

    teardown do
      Timecop.return
    end

    test 'response contains sidekiq status' do
      Sidekiq::Stats.stub(:new, sidekiq_stats_mock) do
        Sidekiq::Stats::History.stub(:new, sidekiq_history_mock) do
          get status_url, env: { 'HTTP_AUTHORIZATION' => @auth }
        end
      end

      expected_status = {
        active_workers: 42,
        queue_sizes: {
          scheduled: 42,
          retries: 42,
          dead: 42
        },
        recent_history: {
          processed: 123,
          failed: 321
        },
        totals: {
          processed: 42,
          failed: 42
        }
      }.deep_stringify_keys
      assert_equal expected_status, response_body['sidekiq']
    end

    test 'response timestamps without refreshed status' do
      request_status

      expected_timestamps = {
        whenever_ran:      nil,
        sidekiq_performed: nil,
        requested:         '2018-01-22 00:00:00'
      }.stringify_keys
      assert_equal expected_timestamps, response_body['timestamps']
    end

    test 'response timestamps with refreshed status' do
      perform_enqueued_jobs do
        Status.refresh
      end
      request_status

      expected_timestamps = {
        whenever_ran:      '2018-01-22 00:00:00',
        sidekiq_performed: '2018-01-22 00:00:00',
        requested:         '2018-01-22 00:00:00'
      }.stringify_keys
      assert_equal expected_timestamps, response_body['timestamps']
    end

    def request_status
      Sidekiq::Stats.stub(:new, OpenStruct.new(queues: {})) do
        Sidekiq::Stats::History.stub(:new, OpenStruct.new) do
          get status_url, env: { 'HTTP_AUTHORIZATION' => @auth }
        end
      end
    end

    def response_body
      JSON.parse response.body
    end

    def sidekiq_stats_mock
      sidekiq_mock = Minitest::Mock.new
      sidekiq_mock.expect(:workers_size, 42, [])
      sidekiq_mock.expect(:queues, {}, [])
      sidekiq_mock.expect(:scheduled_size, 42, [])
      sidekiq_mock.expect(:retry_size, 42, [])
      sidekiq_mock.expect(:dead_size, 42, [])
      sidekiq_mock.expect(:processed, 42, [])
      sidekiq_mock.expect(:failed, 42, [])
      sidekiq_mock
    end

    def sidekiq_history_mock
      history_mock = Minitest::Mock.new
      history_mock.expect(:processed, 123, [])
      history_mock.expect(:failed, 321, [])
      history_mock
    end
  end
end
