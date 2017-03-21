FactoryGirl.define do
  factory :answer do
    association :question
    body "AnswerText"
    user
  end

  factory :invalid_answer, class: Answer do
    association :question
    title nil
    body nil
  end

  factory :new_answer, class: Answer do
    association :question
    title 'New Title'
    body 'new body'
  end
end
