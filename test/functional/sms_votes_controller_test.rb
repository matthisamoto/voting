require 'test_helper'

class SmsVotesControllerTest < ActionController::TestCase
  context "on POST to :create" do
    context "and a valid Twilio signature is provided" do

      context "and voting is turned on" do
        setup do
          Directive.create :message => "start"

          data = {:Body => "I'd like to vote for #{candidates(:grizzly).code}", :From => '9194497859'}
          @request.env["X-Twilio-Signature"] = twilio_signature "sms_votes", data
          post :create, data 
        end

        should_assign_to :vote
        should_respond_with 200
        should_change("the vote count", :by => 1) { Vote.count }
      end

      context "and voting is turned off" do
        setup do
          Directive.create :message => "stop"
          data = {:Body => "I'd like to vote for #{candidates(:grizzly).code}", :From => '9194497859'}
          @request.env["X-Twilio-Signature"] = twilio_signature "sms_votes", data
          post :create, data
        end

        should_respond_with 400
      end
      
      context "and the user is passing an admin directive" do
        setup do 
          data = {:Body => "start", :From => '9194497859'}
          @request.env["X-Twilio-Signature"] = twilio_signature "sms_votes", data
          post :create, data
        end

        should_assign_to :directive
        should_respond_with 200
        should_change("the directive count", :by => 1) { Directive.count }
      end

      context "and the user's candidate code is invalid" do
        setup do
          data = { :From => '9194497859', 
                   :Body => "I'd like to vote for #{88}" }
          @request.env["X-Twilio-Signature"] = twilio_signature "sms_votes", data
          post :create, data
        end
        should_assign_to :vote
        should_respond_with 400
      end

    end

    context "and a valid Twilio signature is not provided" do
      setup do
        Directive.create :message => "start"

        data = {:Body => "I'd like to vote for #{candidates(:grizzly).code}", :From => '9194497859'}
        post :create, data 
      end

      should_respond_with 302
      should_redirect_to("the leaderboard") { votes_url }
    end

  end
end
