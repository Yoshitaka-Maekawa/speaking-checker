class TotalResultsController < ApplicationController
  include FindVideosHelper
  require 'google/apis/youtube_v3'

  def show
    @total_result = current_user.total_results.find(params[:id])
    @total_phase = @total_result.recording_results.map { |result| result.question.phase_before_type_cast }
    @cleared_number = @total_result.judge_phase(phase: @total_phase.uniq.count, score: @total_result.recording_results.last.average_score)
    @total_result.judge_rank(@cleared_number)

    hash = Hash.new
    @total_result.recording_results.each do |result|
      @result_of_each_question = hash.merge!(result.recognized_english => result.average_score)
    end
    @share_tweet = @total_result.call_tweet_share(@cleared_number)
    @youtube_data = find_videos
    reset_session
  end
end
