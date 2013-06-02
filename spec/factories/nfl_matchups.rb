FactoryGirl.define do

	factory :nfl_matchup do

		factory :nfl_matchup1 do
			home_team_id 1
			away_team_id 2
			week 4
			point_spread 5.5
			home_team_score 20
			away_team_score 14
		end

	end

end
