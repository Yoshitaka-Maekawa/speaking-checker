FactoryBot.define do
  factory :recording_result do
    sequence(:recognized_english) { |n| "Question_#{n}." }
    average_score { 85.0 }
    accuracy_score { 85.0 }
    fluency_score { 85.0 }
    completeness_score { 85.0 }
    start_time { Time.current }
    association :question
    association :rank, :normal_rank
    association :total_result

    trait :best_recording_result do
      average_score { 100.0 }
      accuracy_score { 100.0 }
      fluency_score { 100.0 }
      completeness_score { 100.0 }
      association :rank, :best_rank
    end

    trait :good_recording_result do
      average_score { 90.0 }
      accuracy_score { 90.0 }
      fluency_score { 90.0 }
      completeness_score { 90.0 }
      association :rank, :good_rank
    end

    trait :normal_recording_result do
      average_score { 85.0 }
      accuracy_score { 85.0 }
      fluency_score { 85.0 }
      completeness_score { 85.0 }
      association :rank, :normal_rank
    end

    trait :little_bad_recording_result do
      average_score { 80.0 }
      accuracy_score { 80.0 }
      fluency_score { 80.0 }
      completeness_score { 80.0 }
      association :rank, :little_bad_rank
    end

    trait :bad_recording_result do
      average_score { 50.0 }
      accuracy_score { 50.0 }
      fluency_score { 50.0 }
      completeness_score { 50.0 }
      association :rank, :bad_rank
    end
  end
end
