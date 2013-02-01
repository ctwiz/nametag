class UsersController < ApplicationController

  def follow
    follow_id = params[:id]
    unless follow_id.to_i == session[:user_id].to_i
      UserFollower.create(:follower => session[:user_id], :follows => follow_id)
    end
    render :nothing => true
  end

  def show 
    @user = User.find(params[:id])
    @domains = @user.domains
  end
  def create
    @user = params[:user]
    @newuser = User.new(@user)
    @newuser.build_params
    if @newuser.save
      session[:user_id] = @newuser.id
      session[:username] = @newuser.handle
      redirect_to domains_path()
    else 
      flash[:error] = @newuser.errors
      redirect_to signup_path()
    end
  end
end
