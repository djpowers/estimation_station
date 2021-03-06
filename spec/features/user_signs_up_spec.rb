require 'spec_helper'

feature 'user registers for site', %Q{
  As an unregistered user
  I want to register for the site
  So that I may create estimation games
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

    expect(page).to have_content('Welcome! Add a game to get started!')
    expect(page).to have_content('Sign Out')
  end

  scenario 'required information is not supplied' do
    visit root_path
    click_link 'Sign Up'
    click_button 'Sign Up'

    within '.input.string.required.user_first_name' do
      expect(page).to have_content("can't be blank")
    end
    within '.input.string.required.user_last_name' do
      expect(page).to have_content("can't be blank")
    end
    within '.input.email.required.user_email' do
      expect(page).to have_content("can't be blank")
    end
    within '.input.password.required.user_password' do
      expect(page).to have_content("can't be blank")
    end

    expect(page).to_not have_content('Sign Out')
  end

  scenario 'password confirmation does not match password' do
    visit root_path
    click_link 'Sign Up'

    fill_in 'user_password', with: 'password'
    fill_in 'Password Confirmation', with: 'somethingDifferent'
    click_button 'Sign Up'

    within '.input.password.required.user_password_confirmation' do
      expect(page).to have_content("doesn't match")
    end
    expect(page).to_not have_content("Sign Out")
  end

end
