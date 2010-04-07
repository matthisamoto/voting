require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  context "A Vote instance" do
    should_validate_presence_of :candidate_id
    should_belong_to :candidate
  end
end
