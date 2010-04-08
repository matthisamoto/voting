class Directive < ActiveRecord::Base
  validates_presence_of :text
end
