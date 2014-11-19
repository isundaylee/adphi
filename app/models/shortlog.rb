class Shortlog < ActiveRecord::Base
  belongs_to :brother

  serialize :content

  enum log_type: [:plaintext, :attendence]

  validates :brother, presence: true
  validates :log_type, presence: true

  def to_summary_entry
    entry = {
      time: created_at,
    }

    case log_type.to_sym
    when :plaintext
      entry[:description] = content[:text]
    when :attendence
      creator = Brother.find(content[:creator_id])
      meeting = Meeting.find(content[:meeting_id])
      status = content[:status]
      entry[:description] = "[[#{creator.name}]] changed your attendence of [[#{meeting.name}]] on [[#{ApplicationController.helpers.friendly_date(meeting.created_at)}]] at [[#{ApplicationController.helpers.friendly_time(meeting.created_at)}]] to [[#{status.to_s.capitalize}]]"
    end

    entry
  end

  def self.plaintext(brother, text)
    brother.shortlogs.create(
      log_type: "plaintext",
      content: {
        text: text
      }
    )
  end

  def self.attendence(brother, attendence)
    brother.shortlogs.create(
      log_type: "attendence",
      content: {
        creator_id: attendence.creator_id,
        meeting_id: attendence.meeting_id,
        status: attendence.status
      }
    )
  end
end
