class DomainFollower < ActiveRecord::Base
  attr_accessible :follows, :follower

  belongs_to :follower, :class_name => "User", :foreign_key => "follower", :primary_key => "id"
  has_one :domain, :class_name => "Domain", :foreign_key => "id", :primary_key => "id"

end
