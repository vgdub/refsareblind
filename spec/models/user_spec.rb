require 'spec_helper'

describe User do

	describe "associations" do
		it { should have_many(:pools).through(:pool_users) }
	end

	describe "validations" do
		it { should validate_presence_of(:email) }
		it { should_not allow_value("bad_email").for(:email) }
		it { should allow_value("bad_email@gmail.com").for(:email) }
		# it { should validate_uniqueness_of(:email) }
		it { should respond_to(:authenticate) }
	end

end
