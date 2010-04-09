module Sms
  def message
    @message
  end

  def message=(str)
    @message = str
    parse_message self, str
  end

  def parse_message(record, str)
    throw :no_map_routine, "#{self.class.to_s} has no mapping routine."
  end
end
