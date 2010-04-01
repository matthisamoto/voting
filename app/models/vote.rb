class Vote < ActiveRecord::Base
  include Voting

  validates_presence_of :candidate_id
  validates_candidate_presence_in :message

  belongs_to :candidate

  attr_accessor :message
  def message=(str)
    @message = str
    self.candidate = Candidate.find(:all).detect { |c| c if c.code_in?(str) }
  end
end
