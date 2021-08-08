Rails.application.configure do
    config.secret_key = ENV["SECRET_KEY"]
    config.public_key = ENV["PUBLIC_KEY"]
  end