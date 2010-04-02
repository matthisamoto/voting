require 'twiliolib'

class VotesController < ApplicationController
  before_filter :require_twilio, :only => :sms

  def index
    @candidates = Candidate.find :all
  end

  def create
    @vote = Vote.new params[:vote]
    @vote.save
    redirect_to votes_url
  end

  def sms
    @vote = Vote.new :phone_number => params[:From], :message => params[:Body]
    if @vote.save
      response = Twilio::Response.new
      response.append(Twilio::Sms.new("Thanks for voting."))
      render :xml => "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>#{response.respond}", :status => 200
    else
      render :text => "", :status => 400
    end
  end

  def require_twilio
    redirect_to votes_url unless CONFIG['twilio']['sid'] == params[:AccountSid]
  end
end
