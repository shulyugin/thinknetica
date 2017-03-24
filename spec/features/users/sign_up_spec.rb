require 'rails_helper'

feature 'User sign up', %q(
  In order to be able to ask questions
  As a user
  I want to be able to sign up (register)
) do

  scenario 'Visitor is trying to sign up (register)' do
    visit new_user_registration_path
    fill_in 'Email', with: 'test@axample.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content I18n.t('devise.registrations.signed_up')
    expect(current_path).to eq root_path
  end

end
