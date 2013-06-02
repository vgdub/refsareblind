require 'spec_helper'

describe PoolUser do
  describe "associations" do
  	it { should belong_to(:user) }
  	it { should belong_to(:pool) }
  	it { should have_many(:nfl_picks) }
  end

  describe "instance methods" do
  	describe "#nfl_teams_used" do
  		it "returns an array of all teams that the user has already selected" do
  			user = FactoryGirl.create(:user)
  			pool = FactoryGirl.create(:pool)
  			entry = PoolUser.create(user_id: user.id, pool_id: pool.id)
  			entry.nfl_teams_used.should eq []

  			patriots = FactoryGirl.create(:patriots)
  			dolphins = FactoryGirl.create(:dolphins)
  			matchup = NflMatchup.create! home_team_id: patriots.id, away_team_id: 5, week: 1
  			matchup2 = NflMatchup.create! home_team_id: 5, away_team_id: dolphins.id, week: 2
  			matchup.nfl_picks.create user_id: user.id, pool_id: pool.id, locked: true, nfl_team_id: patriots.id, result: "win"
  			matchup.nfl_picks.create user_id: user.id, pool_id: pool.id, locked: true, nfl_team_id: dolphins.id, result: "win"
  			entry.nfl_teams_used.should eq [patriots, dolphins]
  		end
  	end

  end
end
