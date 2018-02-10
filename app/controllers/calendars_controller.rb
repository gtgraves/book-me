class CalendarsController < ApplicationController
  def index
    @calendars = Calendar.all
  end

  def show
    @calendar = Calendar.find(params[:id])
  end

  def new
    require_sign_in
    @calender = Calendar.new
  end

  private
  def require_sign_in
    unless user_signed_in?
      flash[:alert] = "You must be logged in to do that"
      redirect_to new_user_session_path
    end
  end
end
