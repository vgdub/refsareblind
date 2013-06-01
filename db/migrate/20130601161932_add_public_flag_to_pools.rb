class AddPublicFlagToPools < ActiveRecord::Migration
  def change
  	add_column :pools, :public, :boolean, default: false
  	add_column :pools, :name, :string
  	add_column :pools, :slug, :string
  end
end
