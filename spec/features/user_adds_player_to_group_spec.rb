require 'spec_helper'

feature 'user adds player to group', %Q{
  As a user
  I want to add a player to a group
  So that I can record their guesses
} do

  # Acceptance Criteria
  #
  # I must be authenticated
  # I must provide a unique name for a player

  scenario 'valid information is supplied' do
    user = FactoryGirl.create(:user_with_group)
    sign_in_as(user)
    within "#group_#{user.groups.last.id}" do
      click_link 'Show'
    end

    click_link 'Add Player'

    player = FactoryGirl.build(:player)
    fill_in 'Name', with: player.name
    click_button 'Create Player'

    expect(page).to have_content('Player was successfully added.')
  end

  scenario 'name already exists' do
    user = FactoryGirl.create(:user_with_group)
    sign_in_as(user)
    within "#group_#{user.groups.last.id}" do
      click_link 'Show'
    end

    click_link 'Add Player'

    FactoryGirl.create(:player, name: 'Sarah')
    new_player = FactoryGirl.build(:player, name: 'Sarah')
    fill_in 'Name', with: new_player.name
    click_button 'Create Player'

    expect(page).to have_content('Name has already been taken')
  end

  scenario 'name is blank' do
    user = FactoryGirl.create(:user_with_group)
    sign_in_as(user)
    within "#group_#{user.groups.last.id}" do
      click_link 'Show'
    end

    click_link 'Add Player'
    click_button 'Create Player'

    expect(page).to have_content("can't be blank")
  end

end
