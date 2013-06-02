require 'spec_helper'

describe NflTeam do

	describe "associations" do
		it { should have_many(:nfl_picks) }
		it { should have_many(:nfl_matchups) }
	end

end
