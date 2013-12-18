# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Poc::Application.config.secret_key_base = '3afa5ae25ecc1473a3f215a2cf67880405aac1a50089929becc2637dffc320474ef62e2c148427cf8d7f7aceff506648cc9b5a11ef799d820369fee60aa793d1'
