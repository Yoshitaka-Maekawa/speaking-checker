FactoryBot.define do
  factory :rank do
    evaluation { "評価" }
    message { "メッセージ" }

    trait :best_rank do
      evaluation { "帰国子女レベル" }
      message { "ゲームクリア!高得点も目指してみよう！" }
      max_for_each { 100.00 }
      min_for_each { 95.00 }
      max_for_total { 10000 }
      min_for_total { 10 }
    end

    trait :good_rank do
      evaluation { "海外旅行経験者レベル" }
      message { "ゲームクリア目指して頑張ろう!" }
      max_for_each { 94.99 }
      min_for_each { 90.00 }
      max_for_total { 9 }
      min_for_total { 7 }
    end

    trait :normal_rank do
      evaluation { "英会話スクール初学者レベル" }
      message { "あきらめたらこれでゲーム終了ですよ...?" }
      max_for_each { 89.99 }
      min_for_each { 85.00 }
      max_for_total { 6 }
      min_for_total { 5 }
    end

    trait :little_bad_rank do
      evaluation { "小学校高学年レベル" }
      message { "まだまだ君のレベルはこんなものではないはずだ...!" }
      max_for_each { 84.99 }
      min_for_each { 80.00 }
      max_for_total { 4 }
      min_for_total { 3 }
    end

    trait :bad_rank do
      evaluation { "チンパンジーレベル" }
      message { "サンプルボイスを聞いて再度チャレンジしてみよう!" }
      max_for_each { 79.99 }
      min_for_each { 0.00 }
      max_for_total { 2 }
      min_for_total { 0 }
    end
  end
end
