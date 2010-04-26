class Directive < ActiveRecord::Base
  include Sms

  validates_presence_of :instruction

  def parse_message(str)
    if str =~ /start/i
      self.instruction = "start"
    elsif str =~ /stop/i
      self.instruction = "stop"
    end
  end

  def self.can_vote?
    last = find :last
    return false if !last

    if last.instruction == "start"
      return true if (Time.now - last.created_at).round / 60 <= 15
    elsif last.instruction == "stop"
      return false
    end

    false
  end
  
  def self.time_left
    last = find :last
    return false if !last

    if last.instruction == "start"
      remaining = (Time.now - last.created_at).round / 60
      return remaining if remaining <= 15 
      return false 
    elsif last.instruction == "stop"
      return false
    end

    false
  end
end
