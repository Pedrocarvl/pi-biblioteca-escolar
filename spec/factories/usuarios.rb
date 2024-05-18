FactoryBot.define do
  factory :usuario do
    email { "user@example.com" }
    password { "password" }
    password_confirmation { "password" }
    tipo { :user }

    trait :admin do
      tipo { :admin }
    end
  end
end