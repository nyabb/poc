OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '478085175643571','469690208836a77c22b357a891bd8280',
          {
              :scope => 'publish_stream,email,user_birthday,read_stream',
          }
  provider :identity, :model => User
end