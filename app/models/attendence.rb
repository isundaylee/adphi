class Attendence < ActiveRecord::Base
  belongs_to :meeting
  belongs_to :brother
  belongs_to :creator, class_name: 'Brother'

  enum status: [:present, :excused, :tardy, :absent]

  validates :meeting, presence: true
  validates :brother, presence: true, uniqueness: {scope: :meeting_id}
  validates :creator, presence: true
  validates :status, presence: true
end
