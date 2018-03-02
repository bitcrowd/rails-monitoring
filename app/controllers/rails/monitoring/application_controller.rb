module Rails
  module Monitoring
    class ApplicationController < Rails::Monitoring.parent_controller.constantize
      protect_from_forgery with: :exception
    end
  end
end
