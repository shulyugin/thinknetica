FactoryGirl.define do
  factory :question do
    title 'Question Title'
    body 'question body'
    user

    factory :unique_question do
      sequence(:title) { |n| "Question Title #{n}" }
    end

    factory :new_question do
      title 'New Question Title'
      body 'new question body'
    end

    factory :invalid_question do
      title nil
      body nil
      user nil
    end
  end
end
