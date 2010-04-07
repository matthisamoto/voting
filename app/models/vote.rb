class Vote < ActiveRecord::Base
  belongs_to :candidate
  validates_presence_of :candidate_id
end
