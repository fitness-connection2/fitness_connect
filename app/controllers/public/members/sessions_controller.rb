# frozen_string_literal: true

class Public::Members::SessionsController < Devise::SessionsController
  before_action :member_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    new_member_session_path
  end
  
  def guest_sign_in
    member = Member.find_or_create_by(email: "guest@example.com") do |member|
      member.password = SecureRandom.urlsafe_base64
      member.confirmed_at = Time.now # ← Confirmable を設定している場合は追加
      # user.name = "ゲストユーザー" # ←ユーザー名を設定している場合は追加
    end
    sign_in member # ← Deviseのログインメソッド
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました"
  end

  protected

  def member_state
    @member = Member.find_by(email: params[:member][:email])
      if @member.blank?
        flash[:alert] = "必須項目を入力してください。"
        redirect_to new_member_session_path
      elsif @member.valid_password?(params[:member][:password]) && @member.is_delete == true
        flash[:alert] = "退会済みの為、再登録が必要です。"
        redirect_to new_member_session_path
      end
  end
end
