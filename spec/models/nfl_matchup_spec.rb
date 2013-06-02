require 'spec_helper'

describe NflMatchup do
  describe "associations" do
  	it { should belong_to(:home_team) }
  	it { should belong_to(:away_team) }
  end
end
