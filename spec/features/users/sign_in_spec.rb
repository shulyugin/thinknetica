require 'rails_helper'

feature 'User sign in', %q(
  In order to be able to ask questions
  As a user
  I want to be able to sign in
) do

  given(:user) { create(:user) }

  scenario 'Registered user is trying to sign in' do
    sign_in(user)

    expect(page).to have_content I18n.t('devise.sessions.signed_in')
    expect(current_path).to eq root_path
  end

  scenario 'Not registered user fails to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'not-registered@example.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: 'Email')
    expect(current_path).to eq new_user_session_path
  end

end
