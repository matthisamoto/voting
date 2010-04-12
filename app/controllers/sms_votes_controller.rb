class SmsVotesController < ApplicationController
  before_filter :require_twilio, :only => :create

  def create
    if CONFIG['admins'].include?(params[:From].to_i)
      @directive = Directive.new :message => params[:Body]
      if @directive.save
        render :xml => Twilio::Verb.sms("Command accepted."), :status => 200
        return
      end
    end

    vote
  end

  private
  
  def require_twilio
    data = request.url
    data << request.request_parameters.sort { |a,b| a[0].to_s <=> b[0].to_s }.inject("") do |result, p|
      result << p[0].to_s + p[1]
      result
    end

    digest = OpenSSL::Digest::Digest.new("sha1")
    expected = Base64.encode64(OpenSSL::HMAC.digest(digest, CONFIG["twilio"]["token"], data)).strip
    
    redirect_to votes_url unless request.headers["X-Twilio-Signature"] == expected
  end

  def vote
    @vote = SmsVote.new :phone_number => params[:From], :message => params[:Body]
    if Directive.can_vote? && @vote.save
      render :xml => Twilio::Verb.sms("Thanks for voting."), :status => 200
    else
      render :text => "", :status => 400
    end
  end
end
