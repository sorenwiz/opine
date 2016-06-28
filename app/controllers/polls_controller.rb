class PollsController < ApplicationController
  before_filter :get_poll, only: [:show, :vote]
  before_filter :require_user!, only: :vote, unless: :user_signed_in?
  before_filter :set_images, only: :show
  after_filter :clear_saved_vote_id, except: :vote

  def index
    @polls = Poll.active.to_a
  end

  def show
    @vote_options = @poll.vote_options.to_a.shuffle
    @vote_counts = @poll.votes.group(:vote_option_id).count
    @graph_data = @vote_options.map do |vote_option|
      [vote_option.text, @vote_counts.fetch(vote_option.id, 0)]
    end
    @related_polls = Poll.active.where.not(id: @poll.id).first(3)
    @page_title = @poll.heading
    @user_vote = Vote.find_by(user_id: current_user, poll_id: @poll.id) if user_signed_in?
  end

  def vote
    vote_option_id = request.request_parameters[:vote_option_id].presence || session.delete(:last_vote_option_id)
    if vote_option_id.present?
      handle_vote(vote_option_id)
    else
      redirect_to poll_path(@poll)
    end
  end

  private

  def handle_vote(vote_option_id)
    if user_has_voted?
      redirect_to @poll, notice: 'Du har allerede stemt i denne afstemning'
    else
      vote_option = @poll.vote_options.find(vote_option_id)
      Vote.create! user: current_user, poll: @poll, vote_option: vote_option
      redirect_to @poll, notice: 'Din stemme blev gemt!'
    end
  end

  def get_poll
    @poll = Poll.active.find params[:id]
  end

  def require_user!
    session[:last_vote_option_id] = params[:vote_option_id]
    redirect_to user_omniauth_authorize_path(:facebook, origin: vote_poll_path(@poll))
  end

  def user_has_voted?
    Vote.exists?(user_id: current_user, poll_id: @poll.id)
  end

  def clear_saved_vote_id
    session.delete :vote_option_id
  end

  def set_images
    @wallpaper = @poll.wallpaper.url if @poll.wallpaper.exists?
    @poll_image = @poll.image.url(:medium) if @poll.image.exists?
    @poll_title = @poll.heading
  end
end
