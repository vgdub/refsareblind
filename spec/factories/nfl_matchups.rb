FactoryGirl.define do

	factory :nfl_matchup do

		factory :nfl_matchup1 do
			home_team_id 1
			away_team_id 2
			week 1
			point_spread 5.5
			home_team_score 20
			away_team_score 14
		end

		factory :nfl_matchup2 do
			home_team_id 4
			away_team_id 5
			week 2
			point_spread -3
			home_team_score 20
			away_team_score 21
		end

	end

end
