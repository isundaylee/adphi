class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def current_brother
      @current_brother ||= (session[:brother_id] && Brother.find(session[:brother_id]))
    end

    def sign_in(brother)
      session[:brother_id] = brother.id
    end

    def signed_in?
      current_brother != nil
    end

    def sign_out
      session[:brother_id] = nil
    end

    helper_method :current_brother, :signed_in?

end
