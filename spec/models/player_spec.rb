require 'spec_helper'

describe Player do

  it { should have_valid(:name).when("Brian W.", "David") }
  it { should_not have_valid(:name).when(nil, "") }

  it { should validate_uniqueness_of(:name) }

  it { should have_many (:jars) }
  it { should have_many (:guesses) }

end
