module GoogleOauthMockHelper
  def google_oauth_mock(email)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: 123456789,
      info: {
        :name => "John Doe",
        # :email => "john.doe@example.com",
        :email => email,
        :first_name => "John",
        :last_name => "Doe"
      },
      credentials: {
        token: 'token'
      }
    )
  end
end