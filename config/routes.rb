Rails.application.routes.draw do
  devise_for :users
  # ルートパス（/）にアクセスした時に items#index を表示
  root "items#index"

  # items の各アクションを自動で作成
  resources :items

  # health check
  get "up" => "rails/health#show", as: :rails_health_check
end
