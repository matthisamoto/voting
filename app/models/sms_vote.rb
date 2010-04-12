class SmsVote < Vote
  include Sms
  include SmsVoting

  validates_presence_of :phone_number
  validates_candidate_presence_in :message

  def parse_message(str)
    cand = Candidate.find(:all).detect { |c| c if c.code_in?(str) }
    self.candidate = cand if cand
  end
end
