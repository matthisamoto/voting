require 'test_helper'

class SmsVotesControllerTest < ActionController::TestCase
  context "on POST to :create" do
    context "and the request is providing the correct AccountSid" do
      context "and the user's candidate code is valid" do
        setup do
          post :create, 
               { :AccountSid => CONFIG['twilio']['sid'], 
                 :From => '9194497859', 
                 :Body => "I'd like to vote for #{candidates(:grizzly).code}" } 
        end
        should_assign_to :vote
        should_respond_with 200
        should_change("the vote count", :by => 1) { Vote.count }
      end

      context "and the user's candidate code is invalid" do
        setup do
          post :create, 
               { :AccountSid => CONFIG['twilio']['sid'], 
                 :From => '9194497859', 
                 :Body => "I'd like to vote for #{88}" } 
        end
        should_assign_to :vote
        should_respond_with 400
      end
    end

    context "and the request is not providing the correct AccountSid" do
      setup do
        post :create, 
             { :AccountSid => "stnahesuhaosuh",
               :From => '9194497859', 
               :Body => "I'd like to vote for #{candidates(:grizzly).code}" } 
      end
      should_respond_with :redirect
      should_redirect_to("the leaderboard") { votes_url }
    end
  end
end
