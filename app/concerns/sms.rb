module Sms
  def message
    @message
  end

  def message=(str)
    @message = str
    parse_message str
  end

  def parse_message(str)
    throw :no_map_routine, "#{self.class.to_s} has no mapping routine."
  end
end
