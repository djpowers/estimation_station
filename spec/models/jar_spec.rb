require 'spec_helper'

describe Jar do

  before(:each) do
    FactoryGirl.create(:jar)
  end

  describe 'validation' do
    it { should have_valid(:contents).when("Candy Canes", "Gumballs") }
    it { should_not have_valid(:contents).when(nil, "") }

    it { should have_valid(:quantity).when(1, 55, 100) }
    it { should_not have_valid(:quantity).when(nil, "", -1) }

    it { should validate_presence_of :game }
    it { should belong_to :game }

    it { should have_many(:guesses) }
    it { should have_many(:players).through(:guesses) }

    it do
      should validate_uniqueness_of(:contents)
      .scoped_to(:game_id)
      .with_message('A jar with these contents has already been created.')
    end
  end

  describe 'database' do
    it { should have_db_column(:contents).of_type(:string).with_options(null: false) }
    it { should have_db_column(:quantity).of_type(:integer).with_options(null: false) }
    it { should have_db_column(:game_id).of_type(:integer).with_options(null: false) }
  end

  it 'should return the winner for a jar' do
    game = FactoryGirl.create(:game)
    jar = FactoryGirl.create(:jar, contents: 'peanuts')
    player1 = FactoryGirl.create(:player, name: 'David', game_id: game.id)
    player2 = FactoryGirl.create(:player, name: 'Brian', game_id: game.id)
    player3 = FactoryGirl.create(:player, name: 'Craig', game_id: game.id)
    Guess.create(quantity: 500, player_id: player1.id, jar_id: jar.id)
    Guess.create(quantity: 50, player_id: player2.id, jar_id: jar.id)
    Guess.create(quantity: 5, player_id: player3.id, jar_id: jar.id)

    expect(jar.calculate_winner).to eql(player2)
  end

end
