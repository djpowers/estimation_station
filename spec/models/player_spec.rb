require 'spec_helper'

describe Player do

  before(:each) do
    FactoryGirl.create(:player)
  end

  it { should have_valid(:name).when("Brian W.", "David") }
  it { should_not have_valid(:name).when(nil, "") }

  it { should validate_uniqueness_of(:name) }

  it { should validate_presence_of :group }
  it { should belong_to :group }

  it { should have_many(:guesses) }

end
