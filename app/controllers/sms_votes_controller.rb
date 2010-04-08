class SmsVotesController < ApplicationController
  before_filter :require_twilio, :only => :create

  def create
    if CONFIG['admins'].include?(params[:From].to_i)
      admin_directive(params[:Body])
    else
      vote
    end
  end

  private
  
  def require_twilio
    redirect_to votes_url unless CONFIG['twilio']['sid'] == params[:AccountSid]
  end

  def vote
    @last_dir = Directive.find :last
    @vote = SmsVote.new :phone_number => params[:From], :message => params[:Body]
    if (@last_dir.text =~ /start/i && @last_dir.text !=~ /stop/i) && @vote.save
      render :xml => Twilio::Verb.sms("Thanks for voting."), :status => 200
    else
      render :text => "", :status => 400
    end
  end

  def admin_directive(str)
    @directive = Directive.new :text => str
    if @directive.save
      render :xml => Twilio::Verb.sms("Command accepted."), :status => 200
    else
      puts @directive.errors.inspect
      render :xml => Twilio::Verb.sms("There was an error accepting command."), :status => 200
    end
  end
end
