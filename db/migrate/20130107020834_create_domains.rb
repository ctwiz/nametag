class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.integer :user_id
      t.string :name
      t.boolean :public, :default => true
      t.boolean :confirmed, :default => false
      t.boolean :for_sell, :default => true
      t.integer :price, :default => nil
      t.timestamps
    end
  end
end
