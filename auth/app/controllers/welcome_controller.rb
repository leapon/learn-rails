class WelcomeController < ApplicationController
  
  def index
  end

  # Called to receive the token from Google Authentication
  def google_apps_token
    
    puts '>>> request.env["omniauth.auth"]:', request.env["omniauth.auth"]
    
    puts '>>> callback from google apps params:', params
    #puts '>>> receive_token parameters:', omni_params['user_id'], omni_auth['credentials']
    
    render :text => 'google apps token'
    
  end
  
  def google_apps_token2
    
    puts '>>> request.env["omniauth.auth"]:', request.env["omniauth.auth"]
    
    puts '>>> callback from google apps params:', params
    #puts '>>> receive_token parameters:', omni_params['user_id'], omni_auth['credentials']
    
    render :text => 'google apps token2'
    
  end
  
end
