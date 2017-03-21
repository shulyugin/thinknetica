require 'rails_helper'

feature 'Delete answer', %q(
  As an author
  I want to be able to delete the answer on the question page
) do

  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user deletes the answer' do
    sign_in(user)

    visit question_path(question)
    expect(page).to have_content answer.body

    click_on 'delete'
    expect(page).not_to have_content answer.body
  end

  scenario 'User can not delete answers of others' do
    sign_in(other_user)

    visit question_path(question)
    expect(page).not_to have_link 'delete'
  end

  scenario 'Not authenticated user can not delete answers' do
    visit question_path(question)
    expect(page).not_to have_link 'delete'
  end

end
