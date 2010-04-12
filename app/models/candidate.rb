class Candidate < ActiveRecord::Base
  has_many :votes

  validates_presence_of :code, :name
  validates_uniqueness_of :code

  def code_in?(str)
    !!(str =~ Regexp.new(code.to_s))
  end
end
