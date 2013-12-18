
ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :authentication => "plain",
    :domain => 'http://127.0.0.1:3000',
    :user_name => 'pascal.dmec@gmail.com',
    :password => 'rubyonrails',
    :enable_starttls_auto => true
}
