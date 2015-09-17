class WelcomeController < ApplicationController
  
  include JWT
  
  def index
  end

  # Called to receive the token from Google Authentication
  def google_apps_token
    
    #puts '>>> request.env["omniauth.auth"]:', request.env["omniauth.auth"]
    puts '>>> callback from google apps params:', params
    
    omni_auth = request.env['omniauth.auth']
    accessToken = omni_auth.credentials.token
    
    puts ">>> omni_auth:", omni_auth.to_yaml
    #puts ">>> omni_auth.uid:", omni_auth.uid
    #puts ">>> omni_auth.provider:", omni_auth.provider
    #puts ">>> omni_auth.info:", omni_auth.info
    #puts ">>> omni_auth.credentials:", omni_auth.credentials
    #puts ">>> omni_auth.extra:", omni_auth.extra
    
    #puts ">>> omni_auth.credentials.expires:", omni_auth.credentials.expires
    #puts ">>> omni_auth.credentials.expires_at:", omni_auth.credentials.expires_at
    #puts ">>> omni_auth.credentials.token:", omni_auth.credentials.token
    
    omni_params = request.env["omniauth.params"]
    puts ">>> omni_params:", omni_params.to_yaml
    puts ">>> accessToken:", accessToken
    
    user = { :role => 'devops', :email => 'test@example.com' }
    jwt = Medistrano::JWT.from_user(user, user[:role])   #.encoded
    jwt_encoded = Medistrano::JWT.encoded_test(jwt)
    
    puts ">>> jwt:", jwt
    puts ">>> jwt_encoded:", jwt_encoded
    render(json: MultiJson.encode(jwt_encoded), status: 200)
    
    # render webpage
    #render :text => 'google apps token'
    
  end
  
  def google_apps_token2
    #puts '>>> request.env["omniauth.auth"]:', request.env["omniauth.auth"]
    #puts '>>> callback from google apps params:', params
    render :text => 'google apps token2'
  end
  
end

