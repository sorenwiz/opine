class PollsController < ApplicationController

  def index

  end

  def show
    @poll = Poll.find params[:id]
    @vote_options = @poll.vote_options.to_a.shuffle
    @related_polls = Poll.where.not(id: @poll.id).first(3)
    @page_title = @poll.heading
  end
end
