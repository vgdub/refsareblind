require 'spec_helper'

describe NflMatchup do
  describe "associations" do
  	it { should belong_to(:home_team) }
  	it { should belong_to(:away_team) }
  	it { should have_many(:nfl_picks) }
  end

  describe "callbacks" do
  	describe "after_save" do
  		it "should score and update all nfl_picks from that specific matchup if the matchup is updated to final" do
        matchup = FactoryGirl.create(:nfl_matchup1)
        pool_user = FactoryGirl.create(:survival_pool_user)
        pick1 = matchup.nfl_picks.create pool_user_id: pool_user.id, nfl_team_id: 1, locked: true
        pick2 = matchup.nfl_picks.create pool_user_id: pool_user.id, nfl_team_id: 1, locked: true
        pick3 = matchup.nfl_picks.create pool_user_id: pool_user.id, nfl_team_id: 2, locked: true
        [pick1.result, pick2.result, pick3.result].should eq [nil, nil, nil]

        matchup.touch
        [pick1.result, pick2.result, pick3.result].should eq [nil, nil, nil]

        matchup.update_attributes(final: true)
        [pick1.result, pick2.result, pick3.result].should eq ["win", "win", "loss"]
  		end
  	end
  end
end
