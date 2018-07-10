# frozen_string_literal: true

Rails.application.routes.draw do
  get 'activities/index'
  devise_for :users

  root 'phrases#index'

  get 'static_pages/hello'

  resources :activities, only: :index do
    collection do
      put :read_all
    end
  end

  resources :phrases do
    member do
      put 'like', to: 'phrases#upvote'
      put 'dislike', to: 'phrases#downvote'
    end
    resources :examples, only: %i[create destroy] do
      member do
        put 'like', to: 'examples#upvote'
        put 'dislike', to: 'examples#downvote'
      end
    end
  end

  resources :users, only: %i[index show] do
    get :profile, on: :collection
  end
end
