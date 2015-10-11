class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  before_action :set_i18n_locale_from_params
  before_action :authorize

  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :send_failure_mail

  def send_failure_mail
    ApplicationMailer.send_failure_mail.deliver_now
  end

  protected

    def authorize
      unless User.find_by(:id => session[:user_id]) || User.count == 0
        redirect_to login_url, :notice => ":::Please log in"
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
          @locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def default_url_options
      { :locale => I18n.locale }
    end
  
end
