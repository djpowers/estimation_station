require 'spec_helper'

feature 'user signs in', %Q{
  As a user
  I want to sign in
  So that I can access my games
} do

  # Acceptance Criteria
  #
  # If I specify a valid, previously registered email and password, I am authenticated
  # => and I gain access to the system
  # If I specify an invalid email and password, I remain unauthenticated
  # If I am already signed in, I can't sign in again
  # I am redirected to a list of my projects

  scenario 'an existing user specifies a valid emial and password' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    expect(page).to have_content('Welcome back!')
    expect(page).to have_content('Sign Out')
    expect(page).to have_content('Create New Group')
  end

  scenario 'a nonexistant email and password is supplied' do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: 'nobody@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an exisiting email with the wrong password is denied access' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'incorrectPassword'
    click_button 'Sign In'

    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an already authenticated user cannot re-sign in' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit new_user_session_path

    expect(page).to have_content('You are already signed in')
  end

  scenario 'an exisiting user with groups signs in' do
    user = FactoryGirl.create(:user_with_group)
    sign_in_as(user)

    expect(page).to have_content(user.groups.last.title)
  end

end
