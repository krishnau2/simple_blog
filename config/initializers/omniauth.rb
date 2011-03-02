Rails.application.config.middleware.use OmniAuth::Builder do
#  provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, '183175721720888', '0c81fb1daab4b802a46404c3aec7adfb'
end