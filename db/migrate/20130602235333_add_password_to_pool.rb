class AddPasswordToPool < ActiveRecord::Migration
  def change
  	add_column :pools, :access_code, :string
  end
end
