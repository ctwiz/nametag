class UsersController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @domains = @user.domains
    @domains_following = DomainFollower.includes(:domain).where(:follower => @user.id)
    #raise @domains_following.first.domains.to_yaml
  end
  def follow
    follow_id = params[:id]

    unless follow_id.to_i == session[:user_id].to_i
      # User already follows
      unless UserFollower.where(:follower => session[:user_id]).where(:follows => follow_id).empty?
        # Should then unfollow
        UserFollower.where(:follower => session[:user_id]).where(:follows => follow_id).destroy_all
        render :json => true 
        return 
      end

      if UserFollower.create(:follower => session[:user_id], :follows => follow_id)
        render :json => true
      else
        render :json => false
      end
    end
  end

  def show 
    @user = User.find(params[:id])
    @domains = @user.domains
    @followers = @user.followers

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
