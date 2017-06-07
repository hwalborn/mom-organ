class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :index?

  def logged_in?
    !!session[:user_id]
  end

  def index?
    request.url.split('/').last.length >= 5
  end
end
