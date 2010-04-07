class SmsVote < Vote
  include SmsVoting
  validates_candidate_presence_in :message
end
