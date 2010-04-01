require 'twiliolib'

class VotesController < ApplicationController
  def create
    if params[:From] && params[:Body]
      @vote = Vote.new :phone_number => params[:From], :message => params[:Body]
      @vote.save

      response = Twilio::Response.new
      response.append(Twilio::Sms.new("Thanks for voting."))
      puts response.respond
      render :text => response.respond, :status => 200
    else
      render :nothing, :status => 400
    end
  end
end
