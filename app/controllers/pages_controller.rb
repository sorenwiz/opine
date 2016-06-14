class PagesController < ApplicationController
  def concept
  end

  def omos
  end


  def sign_in
    @app_extra_class = 'app-login'
    @skip_content = true
  end
end
