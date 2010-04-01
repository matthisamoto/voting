class Vote < ActiveRecord::Base
  include Sms
  include Voting

  validates_presence_of :phone_number, :message, :candidate_id
  validates_candidate_presence_in :message

  belongs_to :candidate

  attr_accessor :message
  def message=(str)
    @message = str
    self.candidate = Candidate.find(:all).detect { |c| c if c.code_in?(str) }
  end

  after_save do
    puts "SMS Sent!"
  end
end
