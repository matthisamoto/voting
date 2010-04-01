module Voting
  def self.included(base)
    base.extend Validations
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
