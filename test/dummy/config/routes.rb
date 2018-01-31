Rails.application.routes.draw do
  mount SidekiqMonitoring::Engine => '/sidekiq_monitoring'
end
