FactoryGirl.define do

	factory :pool do
		name "Refs Are Blind"
		slug "refs-are-blind"

		factory :survival_pool do
			association :pool_type, factory: :pool_type_survival
		end

		factory :supercontest_pool do
			association :pool_type, factory: :pool_type_supercontest
		end

	end

end
