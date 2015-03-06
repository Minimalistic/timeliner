Rails.application.routes.draw do

  resources :projects
  resources :images

  put '/milestones/import_linkedin_data', to: "milestones#import_linkedin_data", as: :import_linkedin_data

  post '/timelines/:user_id/contact', to: 'timelines#contact', as: 'contact'

  resources :milestones

  root "static_pages#index"
  get 'static_pages/index'

  # resources :users do
  #   resources :timelines, only: [:index]
  # end

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  resources :users, only: [:show, :edit] do
    resources :timelines, only: [:index]
  end
end
