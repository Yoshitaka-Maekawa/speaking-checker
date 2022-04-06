class RecordingResultsController < ApplicationController
  include FindVideosHelper
  require "json"

  def index
    @results = current_user.recording_results.order(start_time: "desc")
    @paginate_results = @results.page(params[:page]).per(10)
  end

  def create
    @result = RecordingResult.new
    transcribed_result = +params.to_unsafe_h.first[1].first[0]  # 文字列を解凍するために先頭に+をつけている
    @result.fetch_transcribed_parameter(transcribed_result)
    @result.judge_rank(@result.average_score)
    @result.start_time = DateTime.now
    @result.total_result_id = session[:total_result]["id"]
    if @result.recognized_english == Question.find_by(english_text: @result.recognized_english)&.english_text
      @result.question_id = Question.find_by(english_text: @result.recognized_english)&.id
    elsif ( @result.question_id.blank? && @result.recognized_english.match?(/[0-9%]/) )
      @result.change_integer_into_string(@result.recognized_english)
      @result.question_id = Question.find_by(english_text: @result.recognized_english)&.id
    end

    if @result.valid?
      @result.save
    else
      flash.now[:danger] = '検証に失敗しました'
      current_phase = Question.find_by(english_text: @result.recognized_english)&.phase_before_type_cast
      @first_question = Question.one.sample.sample
      @next_question = (current_phase < Question.ten.sample.phase_before_type_cast ? Question.where(phase: current_phase + 1).sample : @first_question)
      render template: "questions/show"
    end
  end

  def show
    @result = current_user.recording_results.find(params[:id])
    @youtube_data = find_videos
    gon.accuracy_score = @result.accuracy_score
    gon.fluency_score = @result.fluency_score
    gon.completeness_score = @result.completeness_score
  end

  def narrow_down
    date_array = params[:date].split("-")
    date = Time.local( date_array[0], date_array[1], date_array[2] )
    @paginate_results = current_user.recording_results.where("(recording_results.created_at >= ?) AND (recording_results.created_at <= ?)", date.beginning_of_day, date.end_of_day).page(params[:page])
    @results = current_user.recording_results.where("(recording_results.created_at >= ?) AND (recording_results.created_at <= ?)", date.beginning_of_day, date.end_of_day).order(start_time: "desc")
  end
end
