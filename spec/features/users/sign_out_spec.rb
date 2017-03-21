require 'rails_helper'

feature 'User sign out', %q(
  As an authenticated user
  I want to be able to sign out
) do

  given(:user) { create(:user) }

  scenario 'Authenticated user is trying to sign out' do
    sign_in(user)
    expect(page).to have_content I18n.t('devise.sessions.signed_in')

    page.driver.submit :delete, destroy_user_session_path, {}
    expect(page).to have_content I18n.t('devise.sessions.signed_out')
  end

end
