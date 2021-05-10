require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "validation" do
    context "is valid" do
      it "is valid with nickname, email, password, avator" do
        expect(@user).to be_valid
      end
      it "is valid without avatar" do
        @user.avatar = nil
        expect(@user).to be_valid
      end
    end

    context "is invalid" do
      it "is invalid without nickname" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "is invalid without email" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "is invalid if the email doesm't have @" do
        @user.email = "sample.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "is invalid if the email has already been taken" do
        @user.save
        second_user = FactoryBot.build(:user)
        second_user.email = @user.email
        second_user.valid?
        expect(second_user.errors.full_messages).to include("Email has already been taken")
      end
      it "is invalid without password" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "is invalid if the password doesn't include number" do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it "is invalid if the password doesn't include letters" do
        @user.password = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it "is invalid if the password include Full-width letters" do
        @user.password = "aaaaa１"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
    end
  end
end
