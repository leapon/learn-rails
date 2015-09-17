class WelcomeController < ApplicationController
  
  def index
  end

  # Called to receive the token from Google Authentication
  def google_apps_token
    
    puts '>>> request.env["omniauth.auth"]:', request.env["omniauth.auth"]
    puts '>>> callback from google apps params:', params
    
    omni_params = request.env["omniauth.auth"]
    puts ">>> omni_params:", omni_params.to_s
    
    puts ">>> omni_params.uid:", omni_params.uid
    puts ">>> omni_params.provider:", omni_params.provider
    puts ">>> omni_params.info:", omni_params.info
    puts ">>> omni_params.credentials:", omni_params.credentials
    puts ">>> omni_params.extra:", omni_params.extra
    
    render :text => 'google apps token'
    
  end
  
  def google_apps_token2
    #puts '>>> request.env["omniauth.auth"]:', request.env["omniauth.auth"]
    #puts '>>> callback from google apps params:', params
    render :text => 'google apps token2'
  end
  
end
