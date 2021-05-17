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
      expect(response.status).to eq(200)
    end
    it "responds successfully" do
      @user.save
      post '/users/auth/google_oauth2/callback'
      binding.pry
      expect{User.count}.to change{User.count}.by(0)
    end
  end
end