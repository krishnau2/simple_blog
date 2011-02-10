Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '183175721720888', '0c81fb1daab4b802a46404c3aec7adfb'
end