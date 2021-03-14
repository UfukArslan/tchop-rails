class UserMailer < ApplicationMailer
  def confirm(user)
    @user = user
    mail(to: user.email, subject: "Votre inscription sur le site Tchop")
    # Rails.application.config.site[:name] -> reprend la config.site dans application.rb
  end
end
