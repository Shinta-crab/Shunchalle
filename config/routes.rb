Rails.application.routes.draw do
  # PWA関連のルーティング
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  
  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # トップページ
  root "static_pages#top"

  # 食材とレシピ関連のルーティング
  # foodsのリソースフルルーティングは、検索機能と重複するため、個別に定義
  resources :foods, only: [:new] do
    resources :recipes, only: [:show] # foodsに紐づくrecipesのshowアクション
  end
  post "search", to: "foods#search"
  get "results", to: "foods#results"

  # その他のリソース
  resources :posts

  # 不要なルーティングを削除
  # get "recipes/show" # resources :foods do ... end の記述で代替可能
  # resources :foods # 検索機能と重複するため削除
end