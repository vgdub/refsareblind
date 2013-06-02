FactoryGirl.define do

	factory :nfl_team do

		conference "afc"
		division "east"

		factory :patriots do
			city "new england"
			name "patriots"
			abbr "ne"
		end

		factory :dolphins do
			city "miami"
			name "dolphins"
			abbr "mia"
		end

	end

end
