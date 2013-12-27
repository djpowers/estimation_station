require 'spec_helper'

describe Guess do

  it { should have_valid(:quantity).when(1, 55, 100) }
  it { should_not have_valid(:quantity).when(nil, "", -1) }

  it { should validate_presence_of(:player) }
  it { should belong_to(:player) }

  it { should validate_presence_of(:jar) }
  it { should belong_to(:jar) }

end
