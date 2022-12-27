class InputValidator < ActiveModel::Validator
  def validate(record)
    if record.english_text&.match?(/\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/)
      record.errors[:english_text] << (options[:message] || 'を入力してください。日本語は入力不可です。')
    elsif record.english_text&.match?(/%/)
      record.errors[:english_text] << (options[:message] || 'における "%" は "percent" で入力してください。')
    elsif record.english_text&.match?(/[0-9] percent/)
      record.errors[:english_text] << (options[:message] || 'において、数字とpercentはくっつけて入力してください(例: 100percent)。')
    elsif record.english_text&.match?(/\A[a-z]/)
      record.errors[:english_text] << (options[:message] || 'の先頭の文字は大文字で入力してください。')
    elsif !(record.english_text&.end_with?('.', '?'))
      record.errors[:english_text] << (options[:message] || 'の末尾にカンマ(.)またはクエスチョンマーク(?)を入力してください。')
    end
  end
end
