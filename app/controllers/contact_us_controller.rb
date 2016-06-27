class ContactUsController < ApplicationController
  def create
    is_spam = params[:contact_us_message].delete(:email_confirmation).present?
    if is_spam
      redirect_to(root_path, notice: 'Message was successfully sent.')
      return
    end

    @message = ContactUsMessage.new(params[:contact_us_message])

    if @message.valid? && !is_spam #fake anti spam field
      ContactUsMailer.new_message(@message.name, @message.email, @message.body, @message.subject).deliver_later
      redirect_to(root_path, notice: 'Message was successfully sent.')
    else
      flash.now.alert = 'Please fill all fields.'
      render :new
    end
  end

end
