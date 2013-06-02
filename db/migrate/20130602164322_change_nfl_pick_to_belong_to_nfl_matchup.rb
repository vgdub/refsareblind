class ChangeNflPickToBelongToNflMatchup < ActiveRecord::Migration
  def change
  	remove_column :nfl_picks, :week
  	add_column :nfl_picks, :nfl_matchup_id, :integer
  end
end
