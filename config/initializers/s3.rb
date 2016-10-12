CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => 'AWS',
    :aws_access_key_id => ENV["AMAZON_ACCESS_KEY"],
    :aws_secret_access_key => ENV["AMAZON_SECRET_KEY"],
    :region => 'ap-southeast-1'
  }
  config.fog_directory  = "livegowork"
end