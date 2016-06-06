class HomeController < ApplicationController
  def index

  end

  def show
    render 'polls/show'
  end
end
