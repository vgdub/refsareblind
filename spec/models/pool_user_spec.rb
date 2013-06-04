require 'spec_helper'

describe PoolUser do
  describe "associations" do
  	it { should belong_to(:user) }
  	it { should belong_to(:pool) }
  	it { should have_many(:nfl_picks) }
  end

  context "survival pools" do

    describe "instance methods" do

      before do
        @user = FactoryGirl.create(:user)
  			@pool = FactoryGirl.create(:pool)
        @entry = PoolUser.create(user_id: @user.id, pool_id: @pool.id)
  			@patriots = FactoryGirl.create(:patriots)
  			@dolphins = FactoryGirl.create(:dolphins)
  			@matchup = NflMatchup.create! home_team_id: @patriots.id, away_team_id: 5, week: 1
  			@matchup2 = NflMatchup.create! home_team_id: 5, away_team_id: @dolphins.id, week: 2
      end

      describe "#nfl_teams_used" do
        it "returns an array of all teams that the user has already selected" do
          @entry.nfl_teams_used.should eq []
          @matchup.nfl_picks.create pool_user_id: @entry.id, locked: true, nfl_team_id: @patriots.id, result: "win"
          @matchup2.nfl_picks.create pool_user_id: @entry.id, locked: true, nfl_team_id: @dolphins.id, result: "win"
          @entry.nfl_teams_used.should eq [@patriots, @dolphins]
        end
      end

      describe "#eliminated?" do
        it "returns false for a user that does not have a losing pick" do
          @matchup.nfl_picks.create pool_user_id: @entry.id, locked: true, nfl_team_id: @patriots.id, result: "win"
          @matchup2.nfl_picks.create pool_user_id: @entry.id, locked: true, nfl_team_id: @dolphins.id, result: "win"
          @entry.eliminated?.should be_false
        end

        it "returns true for a user that has a losing pick" do
    			@matchup.nfl_picks.create pool_user_id: @entry.id, locked: true, nfl_team_id: @patriots.id, result: "win"
    			@matchup2.nfl_picks.create pool_user_id: @entry.id, locked: true, nfl_team_id: @dolphins.id, result: "loss"
          @entry.eliminated?.should be_true
        end
      end

      describe "#nfl_survival_pick" do
        it "returns the survival pick for a given week" do
          pick = @matchup.nfl_picks.create pool_user_id: @entry.id, locked: true, nfl_team_id: @patriots.id
          @entry.nfl_survival_pick(1).should eq pick
        end
      end

    end

  end

  context "supercontest pools" do

    before do
      @user = FactoryGirl.create(:user)
      @pool_type = PoolType.create name: "supercontest"
      @pool = FactoryGirl.create(:pool, pool_type_id: @pool_type.id)
      @entry = PoolUser.create(user_id: @user.id, pool_id: @pool.id)
      @patriots = FactoryGirl.create(:patriots)
      @dolphins = FactoryGirl.create(:dolphins)
      @matchup = NflMatchup.create! home_team_id: @patriots.id, away_team_id: 5, week: 1
      @matchup2 = NflMatchup.create! home_team_id: 5, away_team_id: @dolphins.id, week: 2
    end

    describe "instance methods" do

      describe "#weekly_picks" do
        it "returns an array with the entries locked or unlocked weekly picks, given a week, and a boolean 'locked' flag" do
          @entry.weekly_picks(1, true).should eq []
          pick1 = @matchup.nfl_picks.create pool_user_id: @entry.id, locked: true, nfl_team_id: @patriots.id, result: "win"
          pick2 = @matchup2.nfl_picks.create pool_user_id: @entry.id, locked: false, nfl_team_id: @dolphins.id, result: "loss"
          @entry.weekly_picks(1, true).should eq [pick1]
          @entry.weekly_picks(1, false).should eq []
          @entry.weekly_picks(2, true).should eq []
          @entry.weekly_picks(2, false).should eq [pick2]
        end
      end

      describe "#total_score" do
        it "returns the cumulative score for an entry" do
          home_team_covers = NflMatchup.create! home_team_id: 7, away_team_id: 5, home_team_score: 24, away_team_score: 20, point_spread: 3.5, final: false, week: 1
          home_team_wins_no_cover = NflMatchup.create! home_team_id: 7, away_team_id: 5, home_team_score: 24, away_team_score: 20, point_spread: 7.5, final: false, week: 2
          tie = NflMatchup.create! home_team_id: 7, away_team_id: 5, home_team_score: 24, away_team_score: 20, point_spread: 4, final: false, week: 3

          scenarios = [home_team_covers, home_team_wins_no_cover, tie]
          scenarios.each do |matchup|
            @entry.nfl_picks.create pool_user_id: @entry.id, nfl_matchup_id: matchup.id, locked: true, nfl_team_id: 7
          end

          scenarios.each { |matchup| matchup.update_attributes(final: true) }
          @entry.total_score.should eq 1.5
        end
      end

    end

  end

end
