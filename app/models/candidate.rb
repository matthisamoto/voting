class Candidate < ActiveRecord::Base
  validates_presence_of :code, :name
  validates_uniqueness_of :code

  has_many :votes

  def code_in?(str)
    !!(str =~ Regexp.new(code.to_s))
  end
end
