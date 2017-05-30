class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def is_admin?
    if !current_user.is_admin?
      flash[:alert] = "Sorry, You are not an Admin "
      redirect_to root_path
    end
  end


  def is_web_admin?
    if !current_user.is_website_admin?
      flash[:alert] = "Sorry, You are not an Web Admin "
      redirect_to root_path
    end
  end

end
