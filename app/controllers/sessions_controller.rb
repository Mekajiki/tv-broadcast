class SessionsController < ApplicationController
  def create
    user = FacebookAuthenticator.new(request.env['omniauth.auth']).create_or_update_user
    session[:user_id] = user.id
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
