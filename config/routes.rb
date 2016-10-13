Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :projects, only: [:index, :create, :update] do
        member { patch :finish }
      end

      match 'archive', to: 'projects#archive', via: [:patch]

      resources :notes, only: [:create, :destroy]
    end
  end
end
