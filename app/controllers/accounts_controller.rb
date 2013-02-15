class AccountsController < ApplicationController

  def signout
    reset_session
    redirect_to root_path()
  end

  def signup
    @user = User.new
    # if post
    if request.post?
      # toss domains in session
      session[:domains] = params[:domains]
    end
  end

  def signin
    if request.post?
      email = params[:email]
      password = params[:password]
      user = User.find_by_email(email)
      raise user.to_yaml
      if user && user.authenticate(user.password, password, user.password_salt) 
        session[:user_id] = user.id
        session[:username] = user.handle
        redirect_to domains_path()
      else
        redirect_to signin_path(), :flash => { :error => "Invalid email or password" }
      end
    end 
  end
end
