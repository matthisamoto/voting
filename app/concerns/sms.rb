module Sms
  attr_accessor :message
  def message=(str)
    @message = str
    self.candidate = Candidate.find(:all).detect { |c| c if c.code_in?(str) }
  end
end
