# default base class for controllers
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    render text: 'Sorry. The record you requested does not exists'
  end
end
