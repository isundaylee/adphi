class MeetingsController < ApplicationController
  before_action :require_signed_in, only: [:create]

  def index
    @meetings = Meeting.all.reverse
  end

  def show
  end

  def create
    name = params[:name]

    current_brother.meetings.create(name: name)

    redirect_to meetings_url, flash: {success: "You have successfully created the event #{name}. "}
  end
end
