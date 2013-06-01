class CreatePoolTypes < ActiveRecord::Migration
  def change
    create_table :pool_types do |t|
    	t.string :sport
    	t.string :name
    	t.text :description
      t.timestamps
    end
  end
end
