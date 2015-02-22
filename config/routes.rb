Rails.application.routes.draw do

  root "static_pages#index"
  get 'static_pages/index'
  get 'informations/show', as: :personal_info

  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  # devise_scope :user do
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end

end
