require 'rails_helper'

feature 'Create question', %q(
  In order to get an answer from community
  As an authenticated user
  I want to be able to ask question
) do

  given(:user) { create(:user) }

  scenario 'Authenticated user creates a question' do
    sign_in(user)

    visit questions_path
    click_on 'add'
    fill_in 'Title', with: 'Test Question'
    fill_in 'Body', with: 'Test body of test question'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created'
  end

  scenario 'Not authenticated user fails to create a question' do
    visit questions_path
    click_on 'add'

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

end
