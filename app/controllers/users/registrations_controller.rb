# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if params[:sns_auth]
      password = Devise.friendly_token
      params[:user][:password] = password
      params[:user][:password] = password
    end
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    img_check_is = params.require(:img_check_is) 
    if img_check_is == "false"
      @user.avatar.purge
    end

    @user.update(user_params)
    if @user.valid?
      flash[:notice] = "アカウント情報を保存しました"
      redirect_to  edit_user_registration_path
    else
      render :edit
    end
  end
  
  def user_params
    params.require(:user).permit(:avatar, :nickname, :email)
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # def confirm_update
  #   @user = User.find(session["devise.user.id"])
  #   session["devise.update_params"]["password"] = params[:user][:password]
  #   @user.update(session["devise.update_params"])
  #   redirect_to  edit_user_registration_path
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
