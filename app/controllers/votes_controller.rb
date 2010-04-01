class VotesController < ApplicationController
  before_filter :connect

  def index
    
  end

  def create
    @vote = Vote.new(params[:vote])
    @vote.save
  end
end
