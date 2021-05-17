# require 'rails_helper'

# RSpec.describe "GoogleOauth", type: :system do
#   include GoogleOauthMockHelper
  
#   describe "sns authentication" do
#     before do
#       visit root_path
#       today_date = Date.today
#       Calendar.create(id: 1, year: today_date.year, month: today_date.month)
#       Calendar.create(id: 2, year: today_date.year + 1, month: today_date.month + 1)
#       OmniAuth.config.mock_auth[:google_oauth2] = nil
#       Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
#       Rails.application.env_config['omniauth.auth'] = google_oauth_mock()
#     end
#     it "is valid with google authentication" do
#       click_on('Googleでログインする')
#       expect {click_on("登録")}.to change {User.count}.from(0).to(1)
#     end
#   end
# end

#APIのテストではsystem specは適していない可能性があるため、コメントアウトしている