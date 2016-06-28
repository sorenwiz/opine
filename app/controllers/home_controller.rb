class HomeController < ApplicationController
  def index
    @skip_header = true
    @polls = Poll.active.order(:order, :created_at).limit(5).to_a
  end
end
