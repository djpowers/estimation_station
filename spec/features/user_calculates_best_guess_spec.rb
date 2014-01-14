require 'spec_helper'

feature 'user calculates best guess', %Q{
  As a user
  I want to calculate which guess was closest without going over
  So that I may determine the winner for that jar
} do

  # Acceptance Criteria
  #
  # it returns the closet guess for a jar without going over
  # it lists the name of the player who won for a jar
  # it states if there were no guesses below the actual quantity
  # it lists both names in the event of a tie

  scenario 'it returns the player with the best guess' do

    user = FactoryGirl.create(:user_with_group)
    jar = FactoryGirl.create(:jar, group_id: user.groups.first.id)
    player1 = FactoryGirl.create(:player, name: 'John', group_id: user.groups.first.id)
    player2 = FactoryGirl.create(:player, name: 'Jane', group_id: user.groups.first.id)
    sign_in_as(user)

    visit new_group_guess_path(user.groups.first)
    fill_in 'guess_quantity', with: 50
    select player1.name, from: 'guess_player_id'
    select jar.contents, from: 'guess_jar_id'
    click_button 'Create Guess'

    visit new_group_guess_path(user.groups.first)
    fill_in 'guess_quantity', with: 5
    select player2.name, from: 'guess_player_id'
    select jar.contents, from: 'guess_jar_id'
    click_button 'Create Guess'

    visit group_path(user.groups.first)
    # expect(page).to_not have_content(player1.name)
    click_button 'Calculate Winners'
    expect(page).to have_content(player1.name)
  end
end
