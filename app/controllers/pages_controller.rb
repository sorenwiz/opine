class PagesController < ApplicationController
  def concept
  end

  def about_us
  end

  def sign_in
    @app_extra_class = 'app-login'
    @skip_content = true
  end

  def statutes

  end
end
