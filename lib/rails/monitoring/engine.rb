require 'sidekiq'
require 'sidekiq/api'

module Rails
  module Monitoring
    class Engine < ::Rails::Engine
      isolate_namespace Rails::Monitoring
    end
  end
end
