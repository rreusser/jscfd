Jscfd::Application.routes.draw do

  root :to=>'snippets#new'

  resources :snippets

end
