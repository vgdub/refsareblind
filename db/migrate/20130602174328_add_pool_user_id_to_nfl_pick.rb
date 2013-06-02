class AddPoolUserIdToNflPick < ActiveRecord::Migration
  def change
  	add_column :nfl_picks, :pool_user_id, :integer
  end
end
