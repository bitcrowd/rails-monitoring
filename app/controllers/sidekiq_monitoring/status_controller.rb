module SidekiqMonitoring
  class StatusController < ApplicationController
    def status
      render json: {}
    end
  end
end
