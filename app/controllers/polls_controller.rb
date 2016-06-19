class PollsController < ApplicationController
  before_filter :get_poll, only: [:show, :vote]
  before_filter :require_user!, only: :vote, unless: :user_signed_in?

  def index
    @polls = Poll.active.to_a
  end

  def show
    @vote_options = @poll.vote_options.to_a.shuffle
    @related_polls = Poll.active.where.not(id: @poll.id).first(3)
    @page_title = @poll.heading
    @user_vote = Vote.find_by(user_id: current_user, poll_id: @poll.id) if user_signed_in?
  end

  def vote
    vote_option = @poll.vote_options.find(params[:vote_option_id])
    Vote.create! user: current_user, poll: @poll, vote_option: vote_option
    redirect_to @poll, notice: 'Din stemme blev gemt!'
  end

  private

  def get_poll
    @poll = Poll.active.find params[:id]
  end

  def require_user!
    redirect_to sign_in_path(after: poll_path(@poll)) #(poll_id: @poll.id, vote_option_id: params[:vote_option_id])
  end
end
