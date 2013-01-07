class AccountsController < ApplicationController
  def signup
    @user = User.new
  end
end
