require 'twiliolib'

class VotesController < ApplicationController
  before_filter :require_twilio, :only => :sms

  def index
    @candidates = Candidate.find :all
  end

  def create
    @vote = Vote.new params[:vote]
    if @vote.save
      redirect_to votes_url
    else
      index
      render :index
    end
  end

  def sms
    @vote = SmsVote.new :phone_number => params[:From], :message => params[:Body]
    if @vote.save
      response = Twilio::Response.new
      response.append(Twilio::Sms.new("Thanks for voting."))
      render :xml => "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>#{response.respond}", :status => 200
    else
      render :text => "", :status => 400
    end
  end

  def counts
    votes = Candidate.find(:all).inject({}) do |result, c|
      result[c.id] = c.votes.count
      result
    end

    render :json => votes.to_json
  end

  def require_twilio
    redirect_to votes_url unless CONFIG['twilio']['sid'] == params[:AccountSid]
  end
end
