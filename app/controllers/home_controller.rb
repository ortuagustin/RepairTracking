class HomeController < ApplicationController
  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  def index

  end

  def dashboard

  end
private
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def resource_class
    User
  end
end
