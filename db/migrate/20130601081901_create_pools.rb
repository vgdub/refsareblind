class CreatePools < ActiveRecord::Migration
  def change
    create_table :pools do |t|
    	t.integer :pool_type_id
    	t.integer :owner
      t.timestamps
    end
  end
end
