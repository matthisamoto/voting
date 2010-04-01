class Vote < ActiveRecord::Base
  include Sms
  include Voting

  validates_presence_of :phone_number, :message, :candidate_id
  validates_candidate_presence_in :message

  belongs_to :candidate
end
