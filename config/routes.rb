# frozen_string_literal: true

Rails.application.routes.draw do
  get 'activities/index'
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'  }

  root 'phrases#index'

  get 'static_pages/hello'

  resources :activities, only: :index do
    collection do
      put :read_all
    end
  end

  resources :phrases do
    member do
      post :vote
    end
    resources :examples, only: %i[create destroy] do
      post :vote
    end
  end

  resources :users, only: %i[index show] do
    get :profile, on: :collection
  end
end
