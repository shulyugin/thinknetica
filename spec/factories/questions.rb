FactoryGirl.define do
  factory :question do
    title "MyString"
    body "MyText"
    user
  end

  factory :invalid_question, class: Question do
    title nil
    body nil
  end

  factory :new_question, class: Question do
    title 'New Title'
    body 'new body'
  end
end
