import Chart from 'chart.js/auto';
const speechsdk = require('microsoft-cognitiveservices-speech-sdk')
var api_token = ''
var api_region = ''
var timerId = 0

new Vue({
  // viewファイルで#recording(id = recording)が指定されている要素にこのVueの制御を行う
  el: '#recording',

  // データを保存するための変数を定義する部分
  data: {
    status: 'init',     // 状況
  },

  // アプリケーションで使用するメソッドを定義する部分
  methods: {
    // 録音を開始するメソッド。startRecording() {~} は startRecording: functioon() {~}と同じ意味
    startRecording() {
      this.status = 'recording';
      $('.fa-microphone').hide();
      $('.fa-spinner').show();
      if (gon.question_phase == "original" || gon.question_phase == 1) {
        alert('発音の採点時に効果音が流れます。あらかじめ音量を下げておくようご注意ください。');
      }

      const recognizer = getRecognizer(api_token, api_region)
      const english_text = document.getElementById("question-text").innerText;
      const pronunciationAssessmentConfig = new speechsdk.PronunciationAssessmentConfig(english_text, 2, 1, false);
      pronunciationAssessmentConfig.applyTo(recognizer);

      // ブラウザで発音した音声を文字起こしするAPIメソッド。この段階では文字起こし途中の段階
      recognizer.startContinuousRecognitionAsync(() => {
        timerId = setTimeout(() => {
          if (document.getElementById('button-start')) {
            alert('発音を認識できないまま時間が経過いたしました。\nマイクを確認していただき、ページを再読み込みしていただき、再度発音をお願いします。');
            recognizer.stopContinuousRecognitionAsync();
          }
        }, 15500);
      });

      // 文字起こしが完了し、文字起こしデータを返すAPIメソッド
      recognizer.recognized = (_s, e) => {
        clearTimeout(timerId);
        if (e.result.reason == speechsdk.ResultReason.RecognizedSpeech) {
          // APIから返ってきた文字起こしデータをデータベースに保存するため、ajaxでruby側に非同期通信を実行
          $(function () {
            $.ajax({
              type: 'POST',
              url: '/recording_results',
              // フォーム要素の内容をハッシュ形式に変換
              data: e.result.json,
              dataType: "json",
              headers: {
                'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
              },
            })
            .done(function (result) {
              const response_data = JSON.parse(this.data);
              const accuracy_score = response_data.NBest[0].PronunciationAssessment.AccuracyScore;
              const fluency_score = response_data.NBest[0].PronunciationAssessment.FluencyScore;
              const complete_score = response_data.NBest[0].PronunciationAssessment.CompletenessScore;
              const pron_score = response_data.NBest[0].PronunciationAssessment.PronScore;

              const chart_params = {
                type: 'radar',
                data: {
                  labels: [`発音の正確さ ${accuracy_score}点`, `発音の流暢さ ${fluency_score}点`, `発音の完成度 ${complete_score}点`],
                  datasets: [{
                    backgroundColor: "rgba(236, 23, 183,0.5)",
                    borderColor: "rgba(245, 40, 150,1)",
                    borderWidth: 2,
                    pointRadius: 1.5,
                    data: [
                      accuracy_score,
                      fluency_score,
                      complete_score
                    ]
                  }]
                },
                options: {
                  aspectRatio: 2,
                  plugins: {
                    legend: {
                      display: false
                    },
                  },
                  scales: {
                    r: {
                      suggestedMin: 50,
                      max: 100,
                      angleLines: {
                        color: "rgba(238, 130, 238, 0.65)"
                      },
                      grid: {
                        color: "rgba(238, 130, 238, 1)",
                        lineWidth: 2.4
                      },
                      pointLabels: {
                        color: "rgba(0,0,0,1)",
                        font: {
                          size: 16.5,
                          weight: 'bold'
                        },
                      },
                      ticks: {
                        maxTicksLimit: 3,
                        stepSize: 25,
                        color: "rgba(0,0,0,1)",
                        font: {
                          weight: 'bold'
                        }
                      }
                    }
                  }
                }
              }
              const ctx = document.getElementById("myChart");
              const myChart = new Chart(ctx, chart_params);

              const words = response_data.NBest[0].Words;
              const table = document.getElementById('syllable-table');
              for (var i = 0, word_len = words.length; i < word_len; ++i) {
                var syllables = words[i].Syllables;
                for (var v = 0, syllable_len = syllables.length; v < syllable_len; ++v) {
                  const newRow = table.insertRow();
                  const newText = document.createTextNode(syllables[v].Syllable);
                  const newScore = document.createTextNode(`${syllables[v].PronunciationAssessment.AccuracyScore}点`);

                  newRow.insertCell().appendChild(newText);
                  newRow.insertCell().appendChild(newScore);

                  if (syllables[v].PronunciationAssessment.AccuracyScore >= 95.00) {
                    newRow.classList.add("table-primary")
                  } else if (syllables[v].PronunciationAssessment.AccuracyScore <= 70.00) {
                    newRow.classList.add("table-danger")
                  }
                }
              }

              if (gon.question_phase == "original") {
                const english_text = result['english_text']
                const evaluation = result['rank']['evaluation']
                const rank_id = result['rank']['id']
                const twitter = document.getElementById('twitter');
                const tweet = "https://twitter.com/intent/tweet?text="
                + 'あなたの' + '%0a' + `「${english_text}」` + '%0a' + 'の発音レベルは...' + '%0a%0a' + `【${evaluation}】です！` + '%0a%0a'
                + `発音の正確さ　${accuracy_score}点` + '%0a' + `発音の流暢さ　${fluency_score}点` + '%0a' + `発音の完全度　${complete_score}点`
                + '%0a' + '%23' + 'SpeakingChecker' + '%0a' + "&url=https://www.speaking-checker.com";
                twitter.href = tweet;

                $("#question-text").addClass('mt-2');
                $("#button-start").replaceWith('<h4 class="comment_result mt-3">あなたの発音レベルは...</h4>');
                $(".comment_result").after(`<h2 class="comment_${rank_id} my-3" id="comment">${evaluation}</h2>`);
                $('.button-tweet').show();
              } else {
                if (pron_score >= 90.00) {
                  $("#button-start").after('<h1 class="comment_clear my-4">クリア!</h1>');
                  if (gon.question_phase == 10) {
                    $('.final_result').show();
                  } else {
                    $('.next_question').show();
                  }
                } else {
                  $("#button-start").after('<h2 class="comment_gameover my-4">ゲームオーバー!</h2>');
                  $(".comment_gameover").after('<h4 class="comment_nextgame my-4">めのまえが まっくらに なった!</h4>');
                  $('.final_result').show();
                }
                $("#button-start").replaceWith('<h4 class="comment_result mt-3">この問題の判定結果は...</h4>');
              }
              $(".comment_text").hide();
              $('#button-voice').show();
              $('.button-index').show();
              $('.pronounciation-result').show();
              $('.syllables-result').show();
              $('.recommend_question').show();
              var music = new Audio(result['music'])
              music.play();

              recognizer.stopContinuousRecognitionAsync();
              this.status = 'finish_recording';
            })
            .fail(() => {
              $('#button-voice').remove();
              $('#button-start').replaceWith('<button class="btn btn-lg btn-secondary mt-5 mb-4" type="button" disabled=true >ページを読み込み直してください</button>');
              alert(`問題文と異なる英文${e.result.text}を認識しました。問題文と異なる英文は採点できないことをご容赦の上、ページを再読み込みしていただき、再度発音をお願いします。`);
              recognizer.stopContinuousRecognitionAsync();
            });
          });
        }
        else if (e.result.reason == ResultReason.NoMatch) {
          alert('音声の認識に失敗しました。マイクを確認していただき、ページを再読み込みしていただき、再度発音をお願いします。');
          recognizer.stopContinuousRecognitionAsync();
        }
      };

      recognizer.canceled = (_s, e) => {
        alert('サーバーとの通信が途切れました。ページを再読み込みしていただき、再度発音をお願いします。');
        recognizer.stopContinuousRecognitionAsync();
      };

      recognizer.sessionStopped;

      function getRecognizer(token, region) {
        try {
          const speechConfig = speechsdk.SpeechConfig.fromAuthorizationToken(token, region);
          speechConfig.speechRecognitionLanguage = 'en-US';
          const audioConfig = speechsdk.AudioConfig.fromDefaultMicrophoneInput();
          return new speechsdk.SpeechRecognizer(speechConfig, audioConfig);
        } catch (err) {
          alert('サーバーのセッションを取得できませんでした。トップページへ戻ってからページを再読み込みした後、再度最初から問題を進めてください。');
        }
      }
    },

    sampleVoice() {
      $('#button-voice').hide();
      this.status = 'sample_voice';
      const speechConfig = speechsdk.SpeechConfig.fromAuthorizationToken(api_token, api_region);
      const audioConfig = speechsdk.AudioConfig.fromDefaultSpeakerOutput();
      const synthesizer = new speechsdk.SpeechSynthesizer(speechConfig, audioConfig);
      const english_text = document.getElementById("question-text").innerText;

      synthesizer.speakTextAsync(
        english_text,
        result => {
          if (result) {
            synthesizer.close();
            return result.audioData;
          }
        },
        error => {
          alert('問題文の読み上げに失敗しました。ページを再読み込みしていただき、再度発音をお願いします。');
          synthesizer.close();
        }
      );

      setTimeout(() => {
        this.status = 'finish_recording';
        $('#button-voice').show();
      }, 3000);
    },
  },

  // ライフサイクルフック(Railsでいうコールバック?)。mountedはhtmlのDOMが作成された直後の状態で行う処理。
  mounted() {
    navigator.mediaDevices.getUserMedia({ audio: true })      // MediaRecorder APIが提供しているコード。マイクにアクセスできるように設定してある。
    .then(() => {                                         // getUserMediaがPromiseオブジェクトを返すので .then でマイクへのアクセスに成功した後の処理が続く。
      this.status = 'ready';
      $(function () {
        $.ajax({
          type: 'POST',
          url: '/get_token',
          data: undefined,
          dataType: "json",
          contentType: false,
          processData: false,
          headers: {
            'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content')
          },
        })
        .done(function(result) {
          api_token = result['token']['body']
          api_region = result['region']
        })
      })
    });
  }
});
