require 'test_helper'

class CandidateTest < ActiveSupport::TestCase
  context "A Candidate instance" do
    should_validate_presence_of :code, :name
    should_have_many :votes
  
    context "when detecting it's candidate code in a string" do
      setup { subject.code = 601 }
      should "be able to see it if it's present" do
        assert subject.code_in?("I'd like to vote for 601.")
      end
      should "be able to see it if the code isn't the same" do
        assert !subject.code_in?("I'd like to vote for 501.")
      end
      should "be able to see it if the code isn't present" do
        assert !subject.code_in?("I wanna vote for that rad band.")
      end
    end
  end
end
