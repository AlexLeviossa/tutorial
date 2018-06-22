# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'phrases#index'
  get 'phrases/new', to: 'phrases#new'
  post 'phrases', to: 'phrases#create', as: 'phrases'
  get 'phrases', to: 'phrases#index'
  get 'static_pages/hello'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
