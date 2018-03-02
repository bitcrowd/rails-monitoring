Rails.application.routes.draw do
  mount Rails::Monitoring::Engine => '/monitoring'
end
