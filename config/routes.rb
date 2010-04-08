ActionController::Routing::Routes.draw do |map|
  map.resources :votes, :collection => {:counts => :get}
  map.resources :sms_votes
  map.root :controller => :votes, :action => :index
end
