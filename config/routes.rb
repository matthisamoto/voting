ActionController::Routing::Routes.draw do |map|
  map.resources :votes, :collection => {:status => :get}
  map.resources :sms_votes
end
