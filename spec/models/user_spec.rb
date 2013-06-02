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

	end

	end

end
