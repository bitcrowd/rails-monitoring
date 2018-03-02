Rails::Monitoring::Engine.routes.draw do
  controller :status do
    get :status
  end
end
