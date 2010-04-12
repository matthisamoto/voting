module Sms
  def message
    @message
  end

  def message=(str)
    @message = str
    parse_message str
  end

  def parse_message(str)
    throw :no_parse_routine, "#{self.class.to_s} has no parse routine."
  end
end
