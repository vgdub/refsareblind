class AddPublicFlagToPools < ActiveRecord::Migration
  def change
  	add_column :pools, :public, :boolean, default: false
  end
end
