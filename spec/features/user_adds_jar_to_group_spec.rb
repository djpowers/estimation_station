require 'spec_helper'

feature 'user adds jar to group', %Q{
  As a user
  I want to add a jar
  So that players can guess its quantity
} do

  # Acceptance Criteria
  #
  # I must be authenticated
  # I must provide a unique contents for a jar
  # I must provide a positive numerical value for quantity
  # It must be associated wiht a group

  scenario 'valid information is supplied' do
    user = FactoryGirl.create(:user_with_group)
    sign_in_as(user)
    within "#group_#{user.groups.last.id}" do
      click_link 'Show'
    end

    click_link 'Add Jar'

    jar = FactoryGirl.build(:jar)
    fill_in 'Contents', with: jar.contents
    fill_in 'Quantity', with: jar.quantity
    click_button 'Create Jar'

    expect(page).to have_content('Jar was successfully created.')
  end

  scenario 'contents already exists'

  scenario 'blank fields are submitted'

end
