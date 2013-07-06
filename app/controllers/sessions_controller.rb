class SessionsController < ApplicationController
  skip_before_filter :require_login
  before_filter :set_program_filter

  def new
  end

  def create
    user = FacebookAuthenticator.new(request.env['omniauth.auth']).create_or_update_user
    session[:user_id] = user.id if user.active?
    redirect_to root_path
  end

  def failure
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
