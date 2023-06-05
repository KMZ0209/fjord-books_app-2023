# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # コントローラーで許可されたパラメーターを設定するためのフィルター
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[post_code address self_introduction user_icon])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[post_code address self_introduction user_icon])
  end

  private

  def signed_in_root_path(*)
    user_path(current_user)
  end
end
