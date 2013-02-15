class UserFollower < ActiveRecord::Base
  attr_accessible :follows, :follower
  belongs_to :follower, :class_name => "User", :foreign_key => "follower", :primary_key => "id"
  belongs_to :follows, :class_name => "User", :foreign_key => "follows", :primary_key => "id"
  has_many :domains, :class_name => "Domain", :foreign_key => "user_id", :primary_key => "follower"
end
