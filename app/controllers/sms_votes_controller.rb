class SmsVotesController < ApplicationController
  before_filter :require_twilio, :only => :create

  def create
    if CONFIG['admins'].include?(params[:From].to_i)
      @directive = Directive.new :text => params[:Body]
      if @directive.save
        render :xml => Twilio::Verb.sms("Command accepted."), :status => 200
        return
      end
    end

    vote
  end

  private
  
  def require_twilio
    redirect_to votes_url unless CONFIG['twilio']['sid'] == params[:AccountSid]
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
