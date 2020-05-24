# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'static#index'
  get 'home', to: 'static#home', as: 'home'
  get 'about', to: 'static#about', as: 'about'
  get 'teams', to: 'static#teams', as: 'teams'
  get 'documents', to: 'static#documents', as: 'documents'
  get 'mailing-list', to: 'static#mailing_list', as: 'mailing_list'
  get 'camps', to: 'static#camps', as: 'camps'
  get 'admin', to: 'static#admin', as: 'admin'
end
