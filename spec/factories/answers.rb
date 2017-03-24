FactoryGirl.define do
  factory :answer do
    association :question
    body 'answer body'
    user

    factory :unique_answer do
      sequence(:body) { |n| "answer body #{n}" }
    end

    factory :new_answer do
      body 'new answer body'
    end

    factory :invalid_answer do
      body nil
    end
  end
end
