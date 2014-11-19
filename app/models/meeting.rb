class Meeting < ActiveRecord::Base
  belongs_to :creator, class_name: 'Brother'

  validates :creator, presence: true
  validates :name, presence: true, length: {minimum: 1, maximum: 200}
end
