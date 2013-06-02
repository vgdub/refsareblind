class CreateNflPicks < ActiveRecord::Migration
  def change
    create_table :nfl_picks do |t|
    	t.integer :user_id
    	t.integer :pool_id
    	t.integer :nfl_team_id
    	t.integer :week
      t.boolean :locked, default: false
    	t.string :result
      t.timestamps
    end
  end
end
