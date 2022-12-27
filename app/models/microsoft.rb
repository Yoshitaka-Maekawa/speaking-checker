require 'faraday'

class Microsoft < ApplicationRecord
  class << self
    def access
      begin
        connection = Faraday.new( Settings.microsoft[:url] ) do |builder|
          builder.headers['Content-Type'] = 'application/x-www-form-urlencoded'
          builder.headers['Ocp-Apim-Subscription-Key'] = Settings.microsoft[:api_key]
          builder.response :json
        end

        response = connection.post
        puts response
      rescue => e
        puts e
      end
    end
  end
end
