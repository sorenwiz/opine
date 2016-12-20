class VotesController < ApplicationController
  before_filter :require_user!, unless: :user_signed_in?

  def vote
    @poll = Refinery::Polls::Poll.friendly.active.find params[:id]
    vote_option_id = request.request_parameters[:vote_option_id].presence || session.delete(:last_vote_option_id)
    if vote_option_id.present?
      handle_vote(vote_option_id, @poll)
    else
      redirect_to refinery.polls_poll_path(@poll)
    end
  end

  private

  def handle_vote(vote_option_id, poll)
    if user_has_voted?
      redirect_to refinery.polls_poll_path(poll.id, locale: I18n.locale.to_s), notice: t(:votes_notice_1)
    else
      vote_option = poll.vote_options.find(vote_option_id)
      Vote.create! user: current_user, poll_id: poll.id, vote_option_id: vote_option.id
      redirect_to refinery.polls_poll_path(poll, locale: I18n.locale.to_s), notice:  t(:votes_notice_2)
    end
  end

  def require_user!
    session[:last_vote_option_id] = params[:vote_option_id]
    redirect_to user_omniauth_authorize_path(:facebook, origin: poll_vote_path(params[:id], locale: I18n.locale))
  end

  def user_has_voted?
    Vote.exists?(user_id: current_user, poll_id: @poll.id)
  end
end
