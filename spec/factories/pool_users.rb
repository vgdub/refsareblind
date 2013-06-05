FactoryGirl.define do

	factory :pool_user do
		user

		factory :survival_pool_user do
			association :pool, factory: :survival_pool
		end

		factory :supercontest_pool_user do
			association :pool, factory: :supercontest_pool
		end

	end


end
