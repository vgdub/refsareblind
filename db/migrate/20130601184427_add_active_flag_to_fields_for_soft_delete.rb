class AddActiveFlagToFieldsForSoftDelete < ActiveRecord::Migration
  def change
  	add_column :users, :active, :boolean, default: true
  	add_column :pools, :active, :boolean, default: true
  	add_column :pool_users, :approved, :boolean, default: false
  end
end
