class HomeController < ApplicationController
  def index
    @polls = Poll.order(:order, :created_at).limit(5).to_a
  end
end
