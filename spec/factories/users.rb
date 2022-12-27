FactoryBot.define do
  factory :user do
    user_digest { BCrypt::Password.create(SecureRandom.urlsafe_base64) }
    sequence(:email) { |n| "sample_#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    role { 0 }

    trait :admin_user do
      role { 5 }
    end
  end
end
