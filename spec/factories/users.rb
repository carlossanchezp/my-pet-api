FactoryBot.define do
  factory :user do
    email { Faker::Internet.email  }
    auth_token { "5c49c417a4e53a0fe41301f3943fdcec" }
  end
end
