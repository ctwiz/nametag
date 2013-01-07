class CreateUserFollowers < ActiveRecord::Migration
  def change
    create_table :user_followers do |t|
      t.integer :follower
      t.integer :follows
      t.timestamps
    end
  end
end
