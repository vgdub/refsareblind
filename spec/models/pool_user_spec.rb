require 'spec_helper'

describe PoolUser do
  describe "associations" do
  	it { should belong_to(:user) }
  	it { should belong_to(:pool) }
  end
end
