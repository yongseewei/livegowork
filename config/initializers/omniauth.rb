Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['APP_KEY'], ENV['APP_SECRET'], {:scope => 'email, public_profile, user_birthday', :info_fields => 'email,first_name,last_name,gender,birthday', :client_options => { :ssl => { :ca_file => "#{Rails.root}/config/ca-bundle.crt" }}}
  # provider :facebook, ENV['APP_KEY'], ENV['APP_SECRET'], {:scope => 'public_profile', :info_fields => 'email,name,first_name,last_name,gender,birthday', :client_options => { :ssl => { :ca_file => "#{Rails.root}/config/ca-bundle.crt" }}}
end
