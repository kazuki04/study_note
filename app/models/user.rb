class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :notes
  has_many :sns_credentials
  has_many :golas
  has_one_attached :avatar

  validates :nickname, presence: true
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers'

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

    { sns: sns, user: user }
  end
end
