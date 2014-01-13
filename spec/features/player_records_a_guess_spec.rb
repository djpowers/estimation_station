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
    user = FactoryGirl.create(:user_with_group)
    jar = FactoryGirl.create(:jar, group_id: user.groups.first.id)
    player = FactoryGirl.create(:player, group_id: user.groups.first.id)
    sign_in_as(user)
    within "#group_#{user.groups.last.id}" do
      click_link 'Show'
    end

    within "#jar_#{jar.id}" do
      click_link 'Enter Guess'
    end

    fill_in 'guess_quantity', with: 50
    select player.name, from: 'guess_player_id'
    select jar.contents, from: 'guess_jar_id'
    click_button 'Create Guess'

    expect(page).to have_content('Guess was successfully created. Thanks for playing!')
  end

  scenario 'player enters additional guess on a jar'

  scenario 'player submits form with blank fields'

end
