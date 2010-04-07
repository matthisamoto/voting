class SmsVote < Vote
  include SmsVoting
  include Twilio
  validates_candidate_presence_in :message
end
