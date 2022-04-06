module ConversionHelper
  #問題文と録音結果の英文を一致させるための、数字の変換メソッド
  def to_english(object)
    case object
    when 0
      "zero"
    when 1
      "one"
    when 2
      "two"
    when 3
      "three"
    when 4
      "four"
    when 5
      "five"
    when 6
      "six"
    when 7
      "seven"
    when 8
      "eight"
    when 9
      "nine"
    when 10
      "ten"
    when 11
      "eleven"
    when 12
      "twelve"
    when 13
      "thirteen"
    when 14
      "fourteen"
    when 15
      "fifteen"
    when 16
      "sixteen"
    when 17
      "seventeen"
    when 18
      "eighteen"
    when 19
      "nineteen"
    when 20
      "twenty"
    when 30
      "thirty"
    when 40
      "forty"
    when 50
      "fifty"
    when 60
      "sixty"
    when 70
      "seventy"
    when 80
      "eighty"
    when 90
      "ninety"
    when 21 .. 99
      x_one = object % 10
      x_ten = object - x_one
      to_english(x_ten) + " " + to_english(x_one)
    when 100 .. 999
      front_num = object / 100
      rear_num = object % 100
      if rear_num == 0
        to_english(front_num) + " hundred"
      else
        to_english(front_num) + " hundred " + to_english(rear_num)
      end
    when 1e3 .. 999999
      front_num = object / 1000
      rear_num = object % 1000
      if rear_num == 0
        to_english(front_num) + " thousand"
      else
        to_english(front_num) + " thousand " + to_english(rear_num)
      end
    when 1e6 .. 999999999
      front_num = object / 1000000
      rear_num = object % 1000000
      if rear_num == 0
        to_english(front_num) + " million"
      else
        to_english(front_num) + " million " + to_english(rear_num)
      end
    when 1e9 .. 999999999999
      front_num = object / 1000000000
      rear_num = object % 1000000000
      if rear_num == 0
        to_english(front_num) + " billion"
      else
        to_english(front_num) + " billion " + to_english(rear_num)
      end
    when 1e12 .. 999999999999999
      front_num = object / 1000000000000
      rear_num = object % 1000000000000
      if rear_num == 0
        to_english(front_num) + " trillion"
      else
        to_english(front_num) + " trillion " + to_english(rear_num)
      end
    else
      object.to_s
    end
  end

  #"数字 percent"の英文だと%エンコードエラーが発生するので、回避用の処置メソッド。
  def to_number(object)
    case
    when object.match?(/zero percent/)
      object.gsub(/zero percent/, "0percent")
    when object.match?(/Zero percent/)
      object.gsub(/Zero percent/, "0percent")
    when object.match?(/one percent/)
      object.gsub(/one percent/, "1percent")
    when object.match?(/One percent/)
      object.gsub(/One percent/, "1percent")
    when object.match?(/two percent/)
      object.gsub(/two percent/, "2percent")
    when object.match?(/Two percent/)
      object.gsub(/Two percent/, "2percent")
    when object.match?(/three percent/)
      object.gsub(/three percent/, "3percent")
    when object.match?(/Three percent/)
      object.gsub(/Three percent/, "3percent")
    when object.match?(/four percent/)
      object.gsub(/four percent/, "4percent")
    when object.match?(/Four percent/)
      object.gsub(/Four percent/, "4percent")
    when object.match?(/five percent/)
      object.gsub(/five percent/, "5percent")
    when object.match?(/Five percent/)
      object.gsub(/Five percent/, "5percent")
    when object.match?(/six percent/)
      object.gsub(/six percent/, "6percent")
    when object.match?(/Six percent/)
      object.gsub(/Six percent/, "6percent")
    when object.match?(/seven percent/)
      object.gsub(/seven percent/, "7percent")
    when object.match?(/Seven percent/)
      object.gsub(/Seven percent/, "7percent")
    when object.match?(/eight percent/)
      object.gsub(/eight percent/, "8percent")
    when object.match?(/Eight percent/)
      object.gsub(/Eight percent/, "8percent")
    when object.match?(/nine percent/)
      object.gsub(/nine percent/, "9percent")
    when object.match?(/Nine percent/)
      object.gsub(/Nine percent/, "9percent")
    when object.match?(/ten percent/)
      object.gsub(/ten percent/, "10percent")
    when object.match?(/Ten percent/)
      object.gsub(/Ten percent/, "10percent")
    when object.match?(/eleven percent/)
      object.gsub(/eleven percent/, "11percent")
    when object.match?(/Eleven percent/)
      object.gsub(/Eleven percent/, "11percent")
    when object.match?(/twelve percent/)
      object.gsub(/twelve percent/, "12percent")
    when object.match?(/Twelve percent/)
      object.gsub(/Twelve percent/, "12percent")
    when object.match?(/thirteen percent/)
      object.gsub(/thirteen percent/, "13percent")
    when object.match?(/Thirteen percent/)
      object.gsub(/Thirteen percent/, "13percent")
    when object.match?(/fourteen percent/)
      object.gsub(/fourteen percent/, "14percent")
    when object.match?(/Fourteen percent/)
      object.gsub(/Fourteen percent/, "14percent")
    when object.match?(/fifteen percent/)
      object.gsub(/fifteen percent/, "15percent")
    when object.match?(/Fifteen percent/)
      object.gsub(/Fifteen percent/, "15percent")
    when object.match?(/sixteen percent/)
      object.gsub(/sixteen percent/, "16percent")
    when object.match?(/Sixteen percent/)
      object.gsub(/Sixteen percent/, "16percent")
    when object.match?(/seventeen percent/)
      object.gsub(/seventeen percent/, "17percent")
    when object.match?(/Seventeen percent/)
      object.gsub(/Seventeen percent/, "17percent")
    when object.match?(/eighteen percent/)
      object.gsub(/eighteen percent/, "18percent")
    when object.match?(/Eighteen percent/)
      object.gsub(/Eighteen percent/, "18percent")
    when object.match?(/nineteen percent/)
      object.gsub(/nineteen percent/, "19percent")
    when object.match?(/Nineteen percent/)
      object.gsub(/Nineteen percent/, "19percent")
    when object.match?(/twenty percent/)
      object.gsub(/twenty percent/, "20percent")
    when object.match?(/Twenty percent/)
      object.gsub(/Twenty percent/, "20percent")
    when object.match?(/thirty percent/)
      object.gsub(/thirty percent/, "30percent")
    when object.match?(/Thirty percent/)
      object.gsub(/Thirty percent/, "30percent")
    when object.match?(/forty percent/)
      object.gsub(/forty percent/, "40percent")
    when object.match?(/Forty percent/)
      object.gsub(/Forty percent/, "40percent")
    when object.match?(/fifty percent/)
      object.gsub(/fifty percent/, "50percent")
    when object.match?(/Fifty percent/)
      object.gsub(/Fifty percent/, "50percent")
    when object.match?(/sixty percent/)
      object.gsub(/sixty percent/, "60percent")
    when object.match?(/Sixty percent/)
      object.gsub(/Sixty percent/, "60percent")
    when object.match?(/seventy percent/)
      object.gsub(/seventy percent/, "70percent")
    when object.match?(/Seventy percent/)
      object.gsub(/Seventy percent/, "70percent")
    when object.match?(/eighty percent/)
      object.gsub(/eighty percent/, "80percent")
    when object.match?(/Eighty percent/)
      object.gsub(/Eighty percent/, "80percent")
    when object.match?(/ninety percent/)
      object.gsub(/ninety percent/, "90percent")
    when object.match?(/Ninety percent/)
      object.gsub(/Ninety percent/, "90percent")
    when object.match?(/hundred percent/)
      object.gsub(/hundred percent/, "100percent")
    when object.match?(/thousand percent/)
      object.gsub(/thousand percent/, "1000percent")
    when object.match?(/million percent/)
      object.gsub(/million percent/, "1000000percent")
    when object.match?(/billion percent/)
      object.gsub(/billion percent/, "1000000000percent")
    else
      object
    end
  end
end
