require "rails_helper"

RSpec.describe "GoogleOauth", type: :request do
  include GoogleOauthMockHelper
  
  describe "sns authentication" do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = nil
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] 
      @user = FactoryBot.build(:user)
      Rails.application.env_config['omniauth.auth'] = google_oauth_mock(@user.email)
    end
    it "responds successfully" do
      post '/users/auth/google_oauth2/callback'
      expect(response).to have_http_status(200)
    end
    it "is same email if the user have registered in the past" do
      @user.save
      post '/users/auth/google_oauth2/callback'
      sns_info = request.env["omniauth.auth"]
      expect(sns_info[:info][:email] == @user.email).to eq(true)
    end
  end
end