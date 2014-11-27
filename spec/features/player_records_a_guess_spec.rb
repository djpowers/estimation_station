require 'spec_helper'

feature 'player records a guess', %Q{
  As a player
  I want to enter a guess
  So that I can save my estimation for a jar
} do

  # Acceptance Criteria
  #
  # Player must enter a positive number
  # Player cannot edit guess once entered
  # Player cannot see any other guesses
  # Player can only record one guess per jar

  scenario 'player selects name and enters valid guess' do
    user = FactoryGirl.create(:user_with_game)
    jar = FactoryGirl.create(:jar, game_id: user.games.first.id)
    player = FactoryGirl.create(:player, game_id: user.games.first.id)
    sign_in_as(user)
    within "#game_#{user.games.last.id}" do
      click_link 'Show'
    end

    within "#jar_#{jar.id}" do
      click_link 'Enter Guess'
    end

    fill_in 'guess_quantity', with: 50
    select player.name, from: 'guess_player_id'
    click_button 'Create Guess'

    expect(page).to have_content('Guess was successfully created. Thanks for playing!')
  end

  scenario 'player enters additional guess on a jar' do
    user = FactoryGirl.create(:user_with_game)
    jar = FactoryGirl.create(:jar, game_id: user.games.first.id)
    player = FactoryGirl.create(:player, game_id: user.games.first.id)
    FactoryGirl.create(:guess, player_id: player.id, jar_id: jar.id)
    sign_in_as(user)
    within "#game_#{user.games.last.id}" do
      click_link 'Show'
    end

    within "#jar_#{jar.id}" do
      click_link 'Enter Guess'
    end

    fill_in 'guess_quantity', with: 50
    select player.name, from: 'guess_player_id'
    click_button 'Create Guess'

    expect(page).to have_content('This player has already guesses for this jar.')
  end


  scenario 'player submits form with blank fields' do
    user = FactoryGirl.create(:user_with_game)
    jar = FactoryGirl.create(:jar, game_id: user.games.first.id)
    player = FactoryGirl.create(:player, game_id: user.games.first.id)
    sign_in_as(user)
    within "#game_#{user.games.last.id}" do
      click_link 'Show'
    end

    within "#jar_#{jar.id}" do
      click_link 'Enter Guess'
    end
    click_button 'Create Guess'

    expect(page).to have_content('not a number')
  end

end
