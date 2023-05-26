# frozen_string_literal: true

class ApplicationController < ActionController::Base
  around_action :switch_locale
  # ログインしていない時に登録した内容を確認できないようにする
  before_action :authenticate_user!
  # コントローラーで許可されたパラメーターを設定するためのフィルター
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # keys = %i[name self_introduction]
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[post_code address self_introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[post_code address self_introduction])
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def after_sign_in_path_for(*)
    books_path
  end

  def after_sign_out_path_for(*)
    new_user_session_path
  end

  def signed_in_root_path(*)
    user_path(current_user)
  end
end
