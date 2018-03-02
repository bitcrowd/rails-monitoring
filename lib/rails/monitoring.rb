require 'rails/monitoring/engine'

module Rails
  module Monitoring
    mattr_accessor :parent_controller
    self.parent_controller = '::ApplicationController'

    mattr_accessor :http_auth_name
    mattr_accessor :http_auth_password
  end
end
