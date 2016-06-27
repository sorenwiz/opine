class PagesController < ApplicationController
  def concept
  end

  def about_us
    @message = ContactUsMessage.new
  end

  def sign_in
    @app_extra_class = 'app-login'
    @skip_content = true
  end
end
