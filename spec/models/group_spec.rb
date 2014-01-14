require 'spec_helper'

describe Group do

  let(:blanks){ [nil, ''] }

  describe 'validation' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :user }

    it { should belong_to :user }
    it { should have_many(:players).dependent(:destroy) }
    it { should have_many(:jars).dependent(:destroy) }
  end

  describe 'database' do
    it { should have_db_column(:title).of_type(:string).with_options(null: false) }
    it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  end

  it 'returns the winner for a group' do
    group = FactoryGirl.create(:group)
    player = FactoryGirl.create(:player, group_id: group.id)
    jar = FactoryGirl.create(:jar, group_id: group.id)
    guess = Guess.create(quantity: 50, player_id: player.id, jar_id: jar.id)
    expect(group.calculate_winners).to include(player)
  end

end
