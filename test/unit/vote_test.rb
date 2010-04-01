require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  context "A Vote instance" do
    should_validate_presence_of :phone_number, :candidate_id
    should_belong_to :candidate

    context "when assigning a message to it" do
      setup { subject.message = "I'd like to vote for #{candidates(:grizzly).code}." }

      should "detect a Candidate code in the string and link itself to that Candidate" do
        assert subject.candidate_id == candidates(:grizzly).id 
      end
    end
  end
end
