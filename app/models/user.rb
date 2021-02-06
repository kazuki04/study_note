class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :sns_credentials

  def self.from_omniauth(auth_info)
    sns = SnsCredential.where(provider: auth_info.provider, uid: auth_info.uid).first_or_create
    
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email
    )
    
    if user.persisted?
      sns.user = user
      sns.save
    end
    
    return {sns: sns, user: user}

  end

end
