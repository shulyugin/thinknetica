require 'rails_helper'

feature 'View question list', %q(
  In order to be able to read questions
  As a visitor or a user
  I want to be able to view a list of questions
) do

  given(:user) { create(:user) }
  given!(:questions) { create_pair(:unique_question) }

  after do
    expect(page).to have_content "Count: #{questions.count}"

    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end

  scenario 'Visitor views a list of questions' do
    visit questions_path
  end

  scenario 'Authenticated user views a list of questions' do
    sign_in(user)
    visit questions_path
  end

end
