class MeetingsController < ApplicationController
  before_action :require_signed_in, only: [:create, :record]

  def record
    brother = Brother.find(params[:brother_id])
    meeting = Meeting.find(params[:id])
    status = params[:status].to_sym

    puts meeting.creator == current_brother
    puts '#' * 80

    if meeting.creator == current_brother
      attendence = meeting.attendences.find_by(brother_id: brother.id)

      if attendence
        attendence.update(status: status)
      else
        meeting.attendences.create(brother_id: brother.id, status: status, creator_id: current_brother.id)
      end

      Shortlog.attendence(brother, meeting.attendences.find_by(brother_id: brother.id))

      @brother = brother
      @meeting = meeting
      @error = nil
    else
      @error = "You can only record attendence for meetings created by yourself. "
    end

    respond_to do |format|
      format.js
    end
  end

  def index
    @meetings = Meeting.all.reverse
  end

  def show
    @meeting = Meeting.find(params[:id])
  end

  def create
    name = params[:name]

    current_brother.meetings.create(name: name)

    redirect_to meetings_url, flash: {success: "You have successfully created the event #{name}. "}
  end
end
