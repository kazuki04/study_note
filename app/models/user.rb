# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :notes
  has_many :sns_credentials
  has_many :golas
  has_one_attached :avatar

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
