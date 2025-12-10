class ApplicationController < ActionController::Base
  # テスト環境では Basic 認証をスキップする（←これ追加）
  before_action :basic_auth, unless: :skip_basic_auth?

  # Devise用の追加カラム許可
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # Basic 認証
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  # テスト環境のときだけ Basic 認証をオフにする
  def skip_basic_auth?
    Rails.env.test?
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end
end
