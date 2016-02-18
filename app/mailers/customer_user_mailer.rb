class CustomerUserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.customer_user_mailer.password_reset.subject
  #
  def password_reset customer_user
    @customer_user = customer_user
    mail :to => customer_user.email, :subject => "Restableser contraseña"
  end
end
