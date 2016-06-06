class HomeController < ApplicationController
  def index
    @polls = [Poll.new] * 5
  end

  def show
    render 'polls/show'
  end
end
