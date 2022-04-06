class StaticPagesController < ApplicationController
  require 'faraday'

  def top
    @first_question = Question.one.sample
    reset_session
  end

  def help; end

  def terms; end

  def privacy; end

  def inquiry; end

  def get_token
    connection = Faraday.new( Settings.microsoft[:url] ) do |builder|
      builder.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      builder.headers['Ocp-Apim-Subscription-Key'] = Settings.microsoft[:api_key]
      builder.response :json
    end

    response = connection.post
    region = Settings.microsoft[:api_region]
    render json: { token: response,
                   region: region }
  end
end
