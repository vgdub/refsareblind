class CreateNflTeams < ActiveRecord::Migration
  def change
  	create_table "nfl_teams", force: true do |t|
  	  t.string   "city"
  	  t.string   "conference", limit: 3
  	  t.string   "division",   limit: 5
  	  t.string   "name"
  	  t.string   "abbr",       limit: 3
  	  t.datetime "created_at"
  	  t.datetime "updated_at"
  	end
  end
end
