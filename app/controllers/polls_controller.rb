class PollsController < ApplicationController
  before_filter :get_poll, only: [:show, :vote]

  def index

  end

  def show
    @vote_options = @poll.vote_options.to_a.shuffle
    @related_polls = Poll.where.not(id: @poll.id).first(3)
    @page_title = @poll.heading
  end

  def vote
    vote_option = @poll.vote_options.find(params[:vote_option_id])
    Vote.create! user: current_user, poll: @poll, vote_option: vote_option
    redirect_to @poll, notice: 'Din stemme blev gemt!'
  end

  private

  def get_poll
    @poll = Poll.find params[:id]
  end
end
