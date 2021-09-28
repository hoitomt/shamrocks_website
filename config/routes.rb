# frozen_string_literal: true

Rails.application.routes.draw do
  get 'registrations/select', to: 'registrations#select', as: 'select_registration'
  get 'registrations/search', to: 'registrations#search', as: 'search_registrations'
  post 'registrations/edit', to: 'registrations#edit_post', as: 'post_edit_registration'
  resources :registrations, except: [:delete]

  root to: 'static#index'

  get 'home', to: 'static#home', as: 'home'
  get 'about', to: 'static#about', as: 'about'
  get 'teams', to: 'static#teams', as: 'teams'
  get 'documents', to: 'static#documents', as: 'documents'
  get 'registration-letter', to: 'static#registration_letter'
  get 'grievance-document', to: 'static#grievance_document'
  get 'volunteer-code-of-conduct', to: 'static#volunteer_code_of_conduct'
  get 'policy-parents', to: 'static#policy_parents'
  get 'athlete-code-of-conduct', to: 'static#athlete_code_of_conduct'
  get 'waiver', to: 'static#waiver'
  get 'mailing-list' => redirect('https://ecshamrocksbasketball.us12.list-manage.com/subscribe?u=418474835cd2cf8092f6c319d&id=99e9a5e175'), as: 'mailing_list'
  get 'camps', to: 'static#camps', as: 'camps'
  get 'admin', to: 'static#admin', as: 'admin'
end
