require 'spec_helper'

describe Pool do
  describe "associations" do
  	it { should have_many(:users).through(:pool_users) }
  	it { should belong_to(:pool_type) }
  end

  describe "validations" do
  end

end
