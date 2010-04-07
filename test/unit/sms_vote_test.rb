require 'test_helper'

class SmsVoteTest < ActiveSupport::TestCase
  context "A SmsVote instance" do
    context "when assigning a message to it" do
      setup { subject.message = "I'd like to vote for #{candidates(:grizzly).code}." }

      should "detect a Candidate code in the string and link itself to that Candidate" do
        assert subject.candidate_id == candidates(:grizzly).id 
      end
    end
  end
end
