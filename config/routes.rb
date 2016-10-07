Rails.application.routes.draw do
  root 'welcome#home'

   get 'welcome/home'
   resources :jobs
end
