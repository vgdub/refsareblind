require 'spec_helper'

describe Pool do
  describe "associations" do
  	it { should have_many(:users).through(:pool_users) }
  	it { should belong_to(:pool_type) }
  end

  describe "validations" do
  	it { should validate_presence_of(:name) }
  	it { should validate_uniqueness_of(:name) }
  	it { should validate_presence_of(:slug) }
  	# it { should validate_uniqueness_of(:slug) }
  end

  describe "callbacks" do
  	describe "before_create" do
  		it "sets the pool slug to the parameterized version of the pool name" do
  			pool = FactoryGirl.create(:pool, name: "Refs Are Really Blind")
  			pool.slug.should eq "refs-are-really-blind"
  		end
  	end
  end

end
