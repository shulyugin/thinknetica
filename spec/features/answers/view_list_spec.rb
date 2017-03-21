require 'rails_helper'

feature 'View answer list', %q(
  In order to be able to find an answer to the question
  As a visitor or a user
  I want to be able to view a list of answers
) do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answers) { create_pair(:answer, question: question) }

  after do
    expect(page).to have_content "Count: #{answers.count}"

    page_answers = page.all('ul > li').map(&:text)
    page_answers.each_with_index do |text_content, i|
      expect(text_content).to include answers[i].body
    end
  end

  scenario 'Visitor views a list of answers to the question' do
    visit question_path(question)
  end

  scenario 'Authenticated user views a list of answers to the question' do
    sign_in(user)
    visit question_path(question)
  end

end
