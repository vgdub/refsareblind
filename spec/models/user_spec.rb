require 'spec_helper'

describe User do

	describe "associations" do
		it { should have_many(:pools).through(:pool_users) }
		it { should have_many(:nfl_picks) }
	end

	describe "validations" do
		it { should validate_presence_of(:email) }
		it { should_not allow_value("bad_email").for(:email) }
		it { should allow_value("bad_email@gmail.com").for(:email) }
		# it { should validate_uniqueness_of(:email) }
		it { should respond_to(:authenticate) }
	end

	describe "config" do
		describe "#to_s" do
			it "displays the correct name" do
				FactoryGirl.create(:user).to_s.should == "Jordan Leigh"
			end
		end

		describe "#destroy" do
			it "performs a soft delete on the user" do
				user = FactoryGirl.create(:user)
				user.active.should eq true
				user.destroy
				user.active.should eq false
			end
		end

	describe "instance methods" do

		describe "#nfl_teams_used" do
			it "returns an array of all teams that the user has already selected" do
				user = FactoryGirl.create(:user)
				pool = FactoryGirl.create(:pool)
				PoolUser.create(user_id: user.id, pool_id: pool.id)
				user.nfl_teams_used(pool.id).should eq []

				patriots = FactoryGirl.create(:patriots)
				dolphins = FactoryGirl.create(:dolphins)
				matchup = NflMatchup.create! home_team_id: patriots.id, away_team_id: 5, week: 1
				matchup2 = NflMatchup.create! home_team_id: 5, away_team_id: dolphins.id, week: 2
				matchup.nfl_picks.create user_id: user.id, pool_id: pool.id, locked: true, nfl_team_id: patriots.id, result: "win"
				matchup.nfl_picks.create user_id: user.id, pool_id: pool.id, locked: true, nfl_team_id: dolphins.id, result: "win"
				user.nfl_teams_used(pool.id).should eq [patriots, dolphins]
			end
		end

	end

	end

end
