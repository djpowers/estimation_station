require 'spec_helper'

feature 'user adds player to game', %Q{
  As a user
  I want to add a player to a game
  So that I can record their guesses
} do

  # Acceptance Criteria
  #
  # I must be authenticated
  # I must provide a unique name for a player
  # It must be associated with a game

  scenario 'valid information is supplied' do
    user = FactoryGirl.create(:user_with_game)
    sign_in_as(user)
    within "#game_#{user.games.last.id}" do
      click_link 'Show'
    end

    click_link 'Add Player'

    player = FactoryGirl.build(:player)
    fill_in 'Name', with: player.name
    click_button 'Create Player'

    expect(page).to have_content('Player was successfully added.')

    visit game_path(user.games.last)
    expect(page).to have_content(player.name)
  end

  scenario 'name already exists' do
    user = FactoryGirl.create(:user_with_game)
    sign_in_as(user)
    within "#game_#{user.games.last.id}" do
      click_link 'Show'
    end

    click_link 'Add Player'

    FactoryGirl.create(:player, name: 'Sarah')
    new_player = FactoryGirl.build(:player, name: 'Sarah')
    fill_in 'Name', with: new_player.name
    click_button 'Create Player'
    expect(page).to have_content('Player was successfully added.')
    click_link 'Back'
    click_link 'Add Player'
    fill_in 'Name', with: new_player.name
    click_button 'Create Player'
    expect(page).to have_content('has already been created')
  end

  scenario 'name is blank' do
    user = FactoryGirl.create(:user_with_game)
    sign_in_as(user)
    within "#game_#{user.games.last.id}" do
      click_link 'Show'
    end

    click_link 'Add Player'
    click_button 'Create Player'

    expect(page).to have_content("can't be blank")
  end

end
