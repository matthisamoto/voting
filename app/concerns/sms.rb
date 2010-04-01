module Sms
  def send_message(to, msg)
    connect_to_twilio 
    Twilio::Sms.message(CONFIG['twilio']['number'], to, msg) 
  end

  private

  def connect_to_twilio
    Twilio.connect(CONFIG['twilio']['sid'], CONFIG['twilio']['token'])
  end
end
