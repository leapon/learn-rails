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
    puts ">>> jwt encoded and then multijson.encode:", MultiJson.encode(jwt_encoded)
    render(json: MultiJson.encode(jwt_encoded), status: 200)
    
    # render webpage
    #render :text => 'google apps token'
    
  end
  
  def google_apps_token2
    #puts '>>> request.env["omniauth.auth"]:', request.env["omniauth.auth"]
    #puts '>>> callback from google apps params:', params
    render :text => 'google apps token2'
  end
  
  def test_api_call
    
    auth_header = request.headers['Authorization']
    
    if auth_header.downcase.start_with?('bearer')
      jwt = Medistrano::JWT.from_token(auth_header[7..-1] || '')
      raise Api::V0::ControllerError.new('Token is invalid', 403) if jwt.invalid?

      @current_user = User.find_by_email(jwt.payload['email'])
      raise Api::V0::ControllerError.new('Token is invalid', 403) if current_user.nil?

      # We use the role specified in the JWT if supplied; devops should be
      # able to create engineer tokens for themselves in case they want to
      # restrict their own permissions.
      current_user.role = jwt.payload['role'] if jwt.payload['role']
    end
    
  end
  
end

