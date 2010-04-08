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

  def counts
    votes = Candidate.find(:all).inject({}) do |result, c|
      result[c.id] = c.votes.count
      result
    end

    render :json => {:total => Vote.count, :candidates => votes}.to_json
  end
end
