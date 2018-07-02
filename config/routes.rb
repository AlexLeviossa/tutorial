# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'phrases#index'

  get 'static_pages/hello'

  resources :phrases do
    resources :examples, only: %i[create destroy]
  end

  resources :users, only: %i[index show] do
    get :profile, on: :collection
  end
end
