require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  context "on GET to :index" do
    setup { get :index }
    should_assign_to :candidates
    should_respond_with :success
  end

  context "on POST to :create" do
    setup { post :create, :vote => { :candidate_id => candidates(:grizzly).id } }
    should_assign_to :vote
    should_respond_with :redirect
    should_redirect_to("the leaderboard") { votes_url }
    should_change("the vote count", :by => 1) { Vote.count }
  end
end
