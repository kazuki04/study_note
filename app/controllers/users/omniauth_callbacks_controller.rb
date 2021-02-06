# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def google_oauth2
    binding.pry
    authorization
  end

  private
  
  def authorization
    sns_info = User.from_omniauth(request.env["omniauth.auth"])
    @user = sns_info[:user]
    
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      @sns = sns_info[:sns].id
      render template: 'devise/registrations/new'
    end
  end

end
