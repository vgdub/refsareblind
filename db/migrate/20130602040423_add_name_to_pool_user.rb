class AddNameToPoolUser < ActiveRecord::Migration
  def change
  	add_column :pool_users, :name, :string
  end
end
