require 'spec_helper'

describe Jar do

  before(:each) do
    FactoryGirl.create(:jar)
  end

  it { should have_valid(:contents).when("Candy Canes", "Gumballs") }
  it { should_not have_valid(:contents).when(nil, "") }

  it { should validate_uniqueness_of (:contents) }

  it { should have_valid(:quantity).when(1, 55, 100) }
  it { should_not have_valid(:quantity).when(nil, "", -1) }

  it { should validate_presence_of(:player) }
  it { should belong_to(:player) }

  it { should have_many(:guesses) }

end
