Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :projects, only: [:index, :create, :update, :destroy] do
        member { put :finish }
      end

      resources :notes, only: [:create, :destroy]
    end
  end
end
