FactoryGirl.define do
  factory :comment do
    body "HEY"
    message_task
  end

  factory :survey do
    question "What is the cake?"
    answer "A lie!"
  end

end
