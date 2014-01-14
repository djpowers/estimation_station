require 'spec_helper'

describe Player do

  before(:each) do
    FactoryGirl.create(:player)
  end

  describe 'validation' do
    it { should have_valid(:name).when("Brian W.", "David") }
    it { should_not have_valid(:name).when(nil, "") }

    it { should validate_presence_of :group }
    it { should belong_to :group }

    it { should have_many(:guesses) }
    it { should have_many(:jars).through(:guesses) }

    it do
      should validate_uniqueness_of(:name)
      .scoped_to(:group_id)
      .with_message('A player with this name has already been created.')
    end
  end

  describe 'database' do
    it { should have_db_column(:name).of_type(:string).with_options(null: false) }
    it { should have_db_column(:group_id).of_type(:integer).with_options(null: false) }
  end

end
