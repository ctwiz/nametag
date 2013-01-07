class CreateDomainFollowers < ActiveRecord::Migration
  def change
    create_table :domain_followers do |t|
      t.integer :follower
      t.integer :follows
      t.timestamps
    end
  end
end
