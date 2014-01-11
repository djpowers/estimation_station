require 'spec_helper'

feature 'user creates group', %Q{
  As a user
  I want to create a new group
  So that I can associate players and jars with it
} do

  # Acceptance Criteria
  #
  # I must be authenticated to add a group
  # A group title must be provided
  # Group title cannot be duplicated
  # creating a group shows the group page
  # empty group title triggers error message

  scenario 'user is not authenticated' do
    user = FactoryGirl.create(:user)
    visit new_user_group_path(user)

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'required information is supplied' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    click_link 'Create New Group'
    group = FactoryGirl.build(:group)
    fill_in 'Title', with: group.title
    click_button 'Create Group'

    expect(page).to have_content('Group was successfully created.')
    expect(page).to have_content(group.title)
  end

  scenario 'incorrect information is supplied' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    click_link 'Create New Group'
    click_button 'Create Group'

    expect(page).to have_content("can't be blank")
  end


end
