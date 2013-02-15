class Domain < ActiveRecord::Base
  attr_accessible :name, :user_id, :public, :confirmed, :for_sell, :price
  belongs_to :user
  has_many :followers, :class_name => 'DomainFollower', :foreign_key => "follower"

end
