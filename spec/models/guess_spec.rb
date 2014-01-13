require 'spec_helper'

describe Guess do

  it { should have_valid(:quantity).when(1, 55, 100) }
  it { should_not have_valid(:quantity).when(nil, "", -1) }

  it { should validate_presence_of(:player) }
  it { should belong_to(:player) }

  it { should validate_presence_of(:jar) }
  it { should belong_to(:jar) }

  it do
    FactoryGirl.create(:guess)
    should validate_uniqueness_of(:player_id)
    .scoped_to(:jar_id)
    .with_message('This player has already guesses for this jar.')
  end

end
