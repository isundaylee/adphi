class Shortlog < ActiveRecord::Base
  belongs_to :brother

  serialize :content

  enum log_type: [:plaintext]

  validates :brother, presence: true
  validates :log_type, presence: true

  def to_summary_entry
    entry = {
      time: created_at,
    }

    case log_type.to_sym
    when :plaintext
      entry[:description] = content[:text]
    end

    entry
  end

  def self.plaintext(brother, text)
    brother.shortlogs.build(
      log_type: "plaintext",
      content: {
        text: text
      }
    )
  end
end
