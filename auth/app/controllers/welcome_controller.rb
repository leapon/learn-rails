class WelcomeController < ApplicationController
  
  def index
  end

  # Called to receive the token from Google Authentication
  def google_apps_token
    
    #puts '>>> request.env["omniauth.auth"]:', request.env["omniauth.auth"]
    puts '>>> callback from google apps params:', params
    
    omni_auth = request.env['omniauth.auth']
    
    puts ">>> omni_auth.uid:", omni_auth.uid
    puts ">>> omni_auth.provider:", omni_auth.provider
    puts ">>> omni_auth.info:", omni_auth.info
    puts ">>> omni_auth.credentials:", omni_auth.credentials
    puts ">>> omni_auth.extra:", omni_auth.extra
    
    omni_params = request.env["omniauth.params"]
    
    puts ">>> omni_params:", omni_params.to_s
    
    # render webpage
    render :text => 'google apps token'
    
  end
  
  def google_apps_token2
    #puts '>>> request.env["omniauth.auth"]:', request.env["omniauth.auth"]
    #puts '>>> callback from google apps params:', params
    render :text => 'google apps token2'
  end
  
end
