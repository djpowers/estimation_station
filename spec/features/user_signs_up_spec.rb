require 'spec_helper'

feature 'user registers for site', %Q{
  As an unregistered user
  I want to register for the site
  So that I may share and comment on videos
} do

  # Acceptance Criteria
  #
  # registration requires name, email address, password
  # email address must be unique
  # error messgae displayed if fields left blank
  # error messge display if passwords do not match
  # with required information specified, access granted to welcome page

  scenario 'specifying valid and required information' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'First Name', with: 'Dave'
    fill_in 'Last Name', with: 'Powers'
    fill_in 'Email', with: 'dave@estimation_station.com'
    fill_in 'Password', with: 'password', match: :prefer_exact
    fill_in 'Password Confirmation', with: 'password', match: :prefer_exact
    click_button 'Sign Up'

    expect(page).to have_content('Welcome! Add a group to get started!')
    expect(page).to have_content('Sign Out')
  end

end
