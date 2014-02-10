require 'spec_helper'

feature 'user creates game', %Q{
  As a user
  I want to create a new game
  So that I can associate players and jars with it
} do

  # Acceptance Criteria
  #
  # I must be authenticated to add a game
  # A game title must be provided
  # game title cannot be duplicated
  # creating a game shows the game page
  # empty game title triggers error message

  scenario 'user is not authenticated' do
    user = FactoryGirl.create(:user)
    visit new_game_path(user)

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'required information is supplied' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    click_link 'Create New Game'
    game = FactoryGirl.build(:game)
    fill_in 'Title', with: game.title
    click_button 'Create Game'

    expect(page).to have_content('Game was successfully created.')
    expect(page).to have_content(game.title)
  end

  scenario 'incorrect information is supplied' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    click_link 'Create New Game'
    click_button 'Create Game'

    expect(page).to have_content("can't be blank")
  end


end
