class DomainsController < ApplicationController
   
  def index
    @new_domains_ids = add_domains()
    @domains = Domain.where(:user_id => session[:user_id])
    @followers = UserFollower.includes(:user, :user => :domains).where(:follows => session[:user_id])
  end

  def show
    @domain = Domain.includes(:user).find(params[:id])
    @followers = @domain.followers.includes(:user)
    if session[:user_id]
      if @domain.user.id == session[:user_id]
        @is_owner = true
      else
        @is_owner = false
      end
    else
      @is_owner = false
    end

  end

  def follow
    follow_id = params[:id]

    unless DomainFollower.where(:follows => follow_id).where(:follower => session[:user_id]).empty?
      # Should then unfollow
      DomainFollower.where(:follower => session[:user_id]).where(:follows => follow_id).destroy_all
      render :json => true
      return 
    end

    if DomainFollower.create(:follower => session[:user_id], :follows => follow_id)
      render :json => true
    else
      render :json => false
    end
  end


  def add_domains 
    domains = split_domains
    new_domain_ids = []
    if domains 
      domains.each do |domain|
        domain = Domainatrix.parse(domain)
        domain = domain.domain + "." + domain.public_suffix
        if Domain.where(:name => domain, :user_id => session[:user_id]).empty?
          new_domain = Domain.create(:user_id => session[:user_id], :name => domain, :confirmed => false)
          new_domain_ids.push(new_domain.id)
        end
      end
    end
  end

  def split_domains
    if session[:domains] 
      domains = session[:domains].split(/[,\r\n\s]/).reject!(&:empty?)
    elsif params[:domains]
      domains = params[:domains].split(/[,\r\n\s]/).reject!(&:empty?)
    end
  end

  def new
    
  end

end
