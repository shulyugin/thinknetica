require 'rails_helper'

feature 'Delete question', %q(
  As an author
  I want to be able to delete the question
) do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Authenticated user deletes the question' do
    sign_in(user)

    visit question_path(question)
    expect(page).to have_content question.body

    click_on 'Delete question'
    expect(page).not_to have_content question.body
  end

  scenario 'User can not delete questions of others' do
    sign_in(other_user)

    visit question_path(question)
    expect(page).not_to have_link 'Delete question'
  end

  scenario 'Not authenticated user can not delete questions' do
    visit question_path(question)
    expect(page).not_to have_link 'Delete question'
  end

end
