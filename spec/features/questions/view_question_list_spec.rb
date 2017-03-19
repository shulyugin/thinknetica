require 'rails_helper'

feature 'View question list', %q(
  In order to be able to read questions
  As a visitor
  I want to be able to view a list of questions
) do

  given(:user) { create(:user) }
  given!(:questions) { create_pair(:question) }

  after do
    expect(page).to have_content "Count: #{questions.count}"

    page_questions = page.all('ul > li').map(&:text)
    page_questions.each_with_index do |text_content, i|
      expect(text_content).to include questions[i].title
      expect(text_content).to include questions[i].body
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
