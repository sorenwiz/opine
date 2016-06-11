class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    oauth 'Facebook'
  end

  #def failure
  #  render :text => params.inspect
  #end

  def google_oauth2
    oauth 'Google'
  end

  private
  def oauth(kind)
    email = request.env['omniauth.auth']['info']['email']
    @user = User.find_for_oauth(request.env['omniauth.auth'], current_user) if email.present?
    if email && @user.persisted?
      handle_redirect
      sign_in_and_redirect(@user, event: :authentication) #this will throw if @user is not activated
      set_flash_message(:success, :success, kind: kind, name: @user.name) if is_navigational_format?
      session.delete :user_return_to
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to sign_in_url
    end
  end

  def handle_redirect
    redirect_raw = request.env.try(:[],'omniauth.params').try(:[], 'origin')
    redirect = URI(redirect_raw.to_ascii).path if redirect_raw.present?
    session[:user_return_to] = redirect if redirect.present?
  end
end


