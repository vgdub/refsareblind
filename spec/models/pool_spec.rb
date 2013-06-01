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
  	it { should validate_uniqueness_of(:slug) }
  end

  describe "callbacks" do
  	describe "before_validation on create" do
  		it "sets the pool slug to the parameterized version of the pool name" do
  			pool = FactoryGirl.create(:pool, name: "Refs Are Really Blind")
  			pool.slug.should eq "refs-are-really-blind"
  		end
  	end
  end

  describe "config" do
  	describe "#destroy" do
  		it "performs a soft delete on the pool" do
  			pool = FactoryGirl.create(:pool)
  			pool.active.should eq true
  			pool.destroy
  			pool.active.should eq false
  		end
  	end
  end

end
