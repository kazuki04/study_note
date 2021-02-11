class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :notes
  has_many :sns_credentials

  def self.from_omniauth(auth_info)
    sns = SnsCredential.where(provider: auth_info.provider, uid: auth_info.uid).first_or_create
    
    user = User.where(email: auth_info.info.email).first_or_initialize(
      nickname: auth_info.info.name,
      email: auth_info.info.email
    )
    
    if user.persisted?
      sns.user = user
      sns.save
    end
    
    return {sns: sns, user: user}

  end

end
