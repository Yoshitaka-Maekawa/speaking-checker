class QuestionsController < ApplicationController
  include ConversionHelper

  def show
    @question = Question.find(params[:id])
    current_phase = Question.find(params[:id]).phase_before_type_cast
    @next_question = ( !(@question.ten?) ? Question.where(phase: current_phase + 1).sample : @question.phase )

    session[:total_result] = TotalResult.create(rank_id: 1, user_id: @current_user.id) if session[:total_result].blank?
    @total_result = TotalResult.find(session[:total_result]["id"])

    gon.english_text = @question.english_text
    gon.question_phase = current_phase
  end

  def new
    @question = Question.new
    @recommended_question = Question.where(phase: 0).joins(:recording_results).group("recording_results.recognized_english").order(count_all: :desc).count.take(5).sample.first
    @share_tweet = URI.encode_www_form_component("https://twitter.com/intent/tweet")
    session[:total_result] = TotalResult.create(rank_id: 1, user_id: @current_user.id) if session[:total_result].blank?

    gon.question_phase = Question.original.sample.phase
  end

  def create
    @question = Question.new(question_params)
    @question.english_text = to_number(@question.english_text) if @question.english_text.match?(/[a-z] percent/)
    respond_to { |format| ( Question.find_by(english_text: @question.english_text) || @question.save ) ? format.js : format.js { render :errors } }
  end

  def recommended
    @question = Question.find_by(english_text: question_params[:english_text])
    @question.english_text = to_number(@question.english_text) if @question.english_text.match?(/[a-z] percent/)
    respond_to { |format| @question.valid? ? format.js : format.js { render :errors } }
  end

  private

  def question_params
    params.require(:question).permit(:english_text, :phase)
  end
end
