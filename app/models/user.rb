class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :handle, :password, :password_salt

  validates_uniqueness_of :handle
  validates_presence_of :handle, :password, :email
  validates_size_of :handle, :within => 1..20
  validates_size_of :password, :within => 1..100
  validates_format_of :email,
    :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_format_of :handle, :with => /^\w+$/i,
   :message => "can only contain letters and numbers."

  has_many :domains
  has_many :followers, :class_name => 'UserFollower', :foreign_key => "follows" 

  def build_params
    @salt = build_salt
    password_salt = @salt
    @password = build_password(password, password_salt)
    password = @password 
  end

  def build_password(password, salt)
    Digest::MD5.hexdigest(password + salt)
  end

  def build_salt
    o =  [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
    string  =  (0...10).map{ o[rand(o.length)] }.join
  end

  def authenticate(real_password, guess_password, password_salt)
    if real_password == build_password(guess_password, password_salt)
      true
    else
      false
    end
  end

end
