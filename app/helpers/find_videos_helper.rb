module FindVideosHelper
  def find_videos
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = Rails.application.credentials.google[:api_key]

    next_page_token = nil
    service.list_searches(
      :snippet,
      q: "サマー先生と英会話！",
      type: 'video',
      max_results: 10,
      order: :date,
      page_token: next_page_token,
      video_duration: 'medium',
      published_after: 2.years.ago.iso8601,
      published_before: Time.now.iso8601
    )
  end
end
