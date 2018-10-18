class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :authenticate_user!, unless: :devise_controller?
protected
  def set_locale
    I18n.locale = locale_params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def locale_params
    params.permit(:locale)
  end
end
