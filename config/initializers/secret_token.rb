# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

secret = ENV['SAGEPOINT_SECRET']
if secret.nil? || secret.length < 30
  raise "Secret token cannot be loaded"
else
  SagepointApi::Application.config.secret_key_base = secret
  SagepointApi::Application.config.secret_key = secret
end
