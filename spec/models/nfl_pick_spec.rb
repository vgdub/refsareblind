require 'spec_helper'

describe NflPick do
  describe "associations" do
  	it { should belong_to(:user) }
  	it { should belong_to(:pool) }
  	it { should belong_to(:pool_user) }
  	it { should belong_to(:nfl_team) }
  	it { should belong_to(:nfl_matchup) }
  end
end
