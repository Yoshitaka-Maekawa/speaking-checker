FactoryBot.define do
  factory :total_result do
    association :user
    association :rank, :normal_rank

    trait :best_total_result do
      association :rank, :best_rank
    end

    trait :good_total_result do
      association :rank, :good_rank
    end

    trait :normal_total_result do
      association :rank, :normal_rank
    end

    trait :little_bad_total_result do
      association :rank, :little_bad_rank
    end

    trait :bad_total_result do
      association :rank, :bad_rank
    end
  end
end
