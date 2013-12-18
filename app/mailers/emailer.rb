class Emailer < ActionMailer::Base
  default from: "pascal.dmec@gmail.com"
  ActionMailer::Base.default_url_options[:host] = "localhost:3000"

  def registration_from_oauth(user,pass)
    @user = user
    @password = pass;
    mail(to: @user.email, subject: 'Bedankt voor registreren')
  end
end
