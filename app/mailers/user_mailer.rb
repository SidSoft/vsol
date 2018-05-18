class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def notification(email)
    mail to: email, subject: "Welcome message"
  end

  def scheduled(user, message)
    @user = user
    @message = message
    mail to: user.email, subject: "The Empire News"
  end
end
