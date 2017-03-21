require 'rails_helper'

feature 'View question', %q(
  In order to be able to read question
  As a visitor or a user
  I want to be able to view the question
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  after do
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end

  scenario 'Visitor views question title and body' do
    visit question_path(question)
  end

  scenario 'Authenticated user views question title and body' do
    sign_in(user)
    visit question_path(question)
  end

end
