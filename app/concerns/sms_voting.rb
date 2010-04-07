module SmsVoting
  def self.included(base)
    base.extend Validations
  end

  def message
    @message
  end

  def message=(str)
    @message = str
    cand = Candidate.find(:all).detect { |c| c if c.code_in?(str) }
    self.candidate = cand if cand
  end

  module Validations
    def validates_candidate_presence_in(*attributes)
      validates_each(attributes) do |record, attr, value|
        if !Candidate.find(:all).detect { |c| c.code_in?(value) }
          record.errors.add attr, "should contain a valid candidate" 
        end
      end
    end
  end
end
