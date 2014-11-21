class Shortlog < ActiveRecord::Base
  belongs_to :brother

  serialize :content

  enum log_type: [:plaintext, :attendence, :balance]

  validates :brother, presence: true
  validates :log_type, presence: true

  def to_summary_entry
    begin
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
      when :balance
        creator = Brother.find(content[:creator_id])
        balance_title = "#{content[:kind].to_s.capitalize} Job Balance"
        entry[:description] = "[[#{creator.name}]] changed his [[#{balance_title}]] by [[#{content[:change]}]] for [[#{content[:message]}]]"
      end

      entry
    rescue ActiveRecord::RecordNotFound
      # A faster alternative to dependent: :destroy
      nil
    end
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

  def self.balance(brother, creator, kind, change, message)
    brother.shortlogs.create(
      log_type: "balance",
      content: {
        creator_id: creator.id,
        kind: kind,
        change: change,
        message: message
      }
    )
  end
end
