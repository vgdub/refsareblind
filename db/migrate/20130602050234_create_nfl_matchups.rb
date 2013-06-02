class CreateNflMatchups < ActiveRecord::Migration
  def change
    create_table :nfl_matchups do |t|
    	t.integer :home_team_id
    	t.integer :away_team_id
    	t.integer :week
    	t.decimal :point_spread, precision: 3, scale: 1
    	t.integer :home_team_score
    	t.integer :away_team_score
    	t.boolean :final, default: false
      t.timestamps
    end
  end
end
