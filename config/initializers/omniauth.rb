OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '230336277150353', '521b5f03ed172713c4f0bbc9fd9f8364'
end