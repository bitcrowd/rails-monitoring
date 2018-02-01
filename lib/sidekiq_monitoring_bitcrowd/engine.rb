require 'sidekiq'
require 'sidekiq/api'

module SidekiqMonitoring
  class Engine < ::Rails::Engine
    isolate_namespace SidekiqMonitoring
  end
end
