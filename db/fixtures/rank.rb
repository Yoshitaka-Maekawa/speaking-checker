Rank.seed do |s|
  s.id = 1
  s.evaluation = "帰国子女レベル"
  s.message = "ゲームクリア!高得点も目指してみよう！"
  s.max_for_each = 100.00
  s.min_for_each = 95.00
  s.max_for_total = 10000
  s.min_for_total = 10
end

Rank.seed do |s|
  s.id = 2
  s.evaluation = "海外旅行経験者レベル"
  s.message = "ゲームクリア目指して頑張ろう!"
  s.max_for_each = 94.99
  s.min_for_each = 90.00
  s.max_for_total = 9
  s.min_for_total = 7
end

Rank.seed do |s|
  s.id = 3
  s.evaluation = "英会話スクール初学者レベル"
  s.message = "あきらめたらこれでゲーム終了ですよ...?"
  s.max_for_each = 89.99
  s.min_for_each = 85.00
  s.max_for_total = 6
  s.min_for_total = 5
end

Rank.seed do |s|
  s.id = 4
  s.evaluation = "小学校高学年レベル"
  s.message = "まだまだ君のレベルはこんなものではないはずだ...!"
  s.max_for_each = 84.99
  s.min_for_each = 80.00
  s.max_for_total = 4
  s.min_for_total = 3
end

Rank.seed do |s|
  s.id = 5
  s.evaluation = "チンパンジーレベル"
  s.message = "サンプルボイスを聞いて再度チャレンジしてみよう!"
  s.max_for_each = 79.99
  s.min_for_each = 0.00
  s.max_for_total = 2
  s.min_for_total = 0
end
