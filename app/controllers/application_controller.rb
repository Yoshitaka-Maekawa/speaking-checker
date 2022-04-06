class ApplicationController < ActionController::Base
  include SessionsHelper

  add_flash_types :success, :info, :warning, :danger
  before_action :set_user

  if Rails.env.production?
    rescue_from StandardError, with: :render500
    rescue_from ActiveRecord::RecordNotFound, with: :render404
  end

  def render404
    render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false, content_type: 'text/html'
  end

  def render500(error)
    logger.error(error.message)
    logger.error(error.backtrace.join("\n"))
    render file: Rails.root.join('public', '500.html'), status: :internal_server_error, layout: false, content_type: 'text/html'
  end

  private

  def set_user
    unless current_user
      user = User.create_anonymous!
      remember(user)
    end
  end
end
