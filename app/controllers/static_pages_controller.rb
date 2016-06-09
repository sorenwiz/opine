class StaticPagesController < ApplicationController
  def show
    render 'static_pages/konceptet'
  end

  def sign_in
    @app_extra_class = 'app-login'
    @skip_content = true
    render 'static_pages/sign_in'
  end
end
