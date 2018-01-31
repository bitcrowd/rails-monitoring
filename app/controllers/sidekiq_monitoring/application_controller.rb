module SidekiqMonitoring
  class ApplicationController < SidekiqMonitoring.parent_controller.constantize
    protect_from_forgery with: :exception
  end
end
