class MeetingsController < ApplicationController
  before_action :require_signed_in, only: [:create, :record]

  load_and_authorize_resource

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
    @meetings = Meeting.all.reverse.map do |m|
      r = {
        meeting: m,
        present: m.attendences.where(status: Attendence.statuses[:present]).size,
        excused: m.attendences.where(status: Attendence.statuses[:excused]).size,
        tardy: m.attendences.where(status: Attendence.statuses[:tardy]).size,
        absent: m.attendences.where(status: Attendence.statuses[:absent]).size,
      }

      r[:rate] = 1.0 * r[:present] / Brother.current.size

      r
    end
  end

  def show
    @meeting = Meeting.find(params[:id])
    @attendences = @meeting.attendences.group_by { |a| a.brother_id }.hmap do |b, as|
      [b, as[0]]
    end
  end

  def create
    name = params[:name]

    meeting = current_brother.meetings.create(name: name)

    redirect_to meeting_url(meeting), flash: {success: "You have successfully created the event #{name}. "}
  end

  def destroy
    meeting =  Meeting.find(params[:id])

    if meeting.creator != current_brother
      @error = "You can only delete meetings created by yourself. "
    else
      meeting.destroy
      @meeting = meeting
    end

    respond_to do |format|
      format.js
    end
  end
end
