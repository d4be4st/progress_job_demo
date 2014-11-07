Rails.application.routes.draw do
  root to: 'exports#index'
  get 'export_users' => 'exports#export_users', as: :export_users
end
