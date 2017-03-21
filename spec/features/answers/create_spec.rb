require 'rails_helper'

feature 'Create answer', %q(
  In order to answer to the question
  As an authenticated user
  I want to be able to create an answer on the question page
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Authenticated user creates an answer' do
    sign_in(user)

    visit question_path(question)
    fill_in 'answer[body]', with: 'Test body of test answer'
    click_on 'Answer the question'

    expect(page).to have_content 'Test body of test answer'
  end

  scenario 'Not authenticated user fails to create an answer' do
    visit question_path(question)

    expect(page).not_to have_field 'answer[body]'
  end

end
