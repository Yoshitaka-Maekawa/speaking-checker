# Speaking_checker

## アプリURL
https://www.speaking-checker.com/

## サービス概要
英語の発音精度を教えてくれるサービスです。

## サービスを作ったキッカケ
#### - 英語塾での一言
高校時代に英語塾に通っていたのですが、英単語の発音をしていたら塾長から「その発音間違えてるよ」と言われた経験が何度かありました。自分は正しいと思っていたやり方で発音していたのですが、実際は間違っていることを指摘されるたびにハッと気付かされました。当時は発音を確認するには塾長の助けが必要でしたが、「自分の発音が合っているか間違っているかを一人で判断できたら」と思ったのが1つ目のキッカケです

#### - 旅先での外国人との会話
旅先のカプセルホテルで外国人の方から話しかけられたことがありました。なんとか英語で会話しようと試みましたが、相手の方によく伝わってない様子でした。その時はなんとかボディーランゲージで乗り切りましたが、自身の英会話力のなさを痛感したと同時に、「自分の発音は外国人の方にはどう聞こえているのだろう？」と思ったのが2つ目のキッカケです

主に以上の2つのキッカケから、自分の英語の発音精度を確認できないか？と考えこのサービスを開発しました。

## サービスを作った思い
**「英語に興味を持つ人を増やしたい」**<br>
英語を1日1フレーズ話すだけでも、英語力に自信を持てたり、英語に対する苦手意識を克服できるかもしれません。<br>
このアプリを通じて、英語を話すことに前向きな人が一人でも増えてくれると嬉しいです。

## 主なページと機能紹介
| Topページ | 英文発音ページ |
| ---- | ---- |
| [![Image from Gyazo](https://i.gyazo.com/b38c76ef3768beb2a59a59cd9a49c605.png)](https://gyazo.com/b38c76ef3768beb2a59a59cd9a49c605) | [![Image from Gyazo](https://i.gyazo.com/876355557a0294a2028cd02885432258.gif)](https://gyazo.com/876355557a0294a2028cd02885432258) |
| 用意された英文を発音していくゲームモードと、自作の英文の発音精度を確認できる2種類あります。 | 英文を発音していただき、発音精度の診断結果から次の問題へ進めるかを判断しています。発音がわからない場合でもサンプルボイスを用意しています。 |

| 最終結果ページ | 英文作成ページ |
| ---- | ---- |
| [![Image from Gyazo](https://i.gyazo.com/2949f2710e14b902b7e08d2ec6ab1f7e.gif)](https://gyazo.com/2949f2710e14b902b7e08d2ec6ab1f7e) | [![Image from Gyazo](https://i.gyazo.com/6f9ed27d64f100f5b964804393a2f670.gif)](https://gyazo.com/6f9ed27d64f100f5b964804393a2f670) |
| 進められた問題数に応じて、最終的な発音のランクを表示しています。発音を少しでも改善できるようにYouTube動画を提案しています。 | 英文を作成することが可能です。ユーザーが発音を確認したい英文も発音精度を診断してくれます。 |

| 発音履歴ページ | ランキングページ |
| ---- | ---- |
| [![Image from Gyazo](https://i.gyazo.com/cacfa334340f03600ac0ac883a3b6a7d.gif)](https://gyazo.com/cacfa334340f03600ac0ac883a3b6a7d) | [![Image from Gyazo](https://i.gyazo.com/4ef9c66edc0b70309cd68a3c91bb6085.gif)](https://gyazo.com/4ef9c66edc0b70309cd68a3c91bb6085) |
| 今まで発音した英文とその結果をカレンダー形式で振り返ることができます。 | ゲームモードで用意されている英文の発音精度をランキングで表示させてます。 |

## 使用技術
### バックエンド
- Ruby 3.1.2
- Rails 6.1.6

### フロントエンド
- HTML
- CSS(SCSS)
- JavaScript(jQuery)

### 外部API
- Azure Cognitive Services「Speech to Text API」
- YouTube Data API

## ER図
[![Image from Gyazo](https://i.gyazo.com/bb6b24a7924e1e62bc87d9a10d1db8c6.png)](https://gyazo.com/bb6b24a7924e1e62bc87d9a10d1db8c6.png)

https://drive.google.com/file/d/1R5XKx37M92r2x-g4nI9asEQkzH_AvX69/view?usp=sharing
