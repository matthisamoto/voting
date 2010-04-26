class VotesController < ApplicationController
  def index
    @candidates = Candidate.find :all
    @total_votes = Vote.count
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

  def status
    if Directive.can_vote?
      votes = Candidate.find(:all).inject({}) do |result, c|
        result[c.id] = c.votes.count
        result
      end

      remaining = 15 - ((Time.now - Directive.find(:last).created_at).round / 60)
      
      render :json => {:status => "on", :time_remaining => remaining, :total => Vote.count, :candidates => votes}.to_json
    else
      render :json => {:status => "off"}.to_json
    end
  end
end
