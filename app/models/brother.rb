class Brother < ActiveRecord::Base
  scope :current, -> { where(current: true) }

  belongs_to :pledge_class

  has_many :shortlogs
  has_many :meetings, foreign_key: 'creator_id'
  has_many :attendences

  validates :name, presence: true, length: {minimum: 1, maximum: 100}
  validates :kerberos, presence: true, length: {minimum: 1, maximum: 8}
  validates :year, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1900, less_than_or_equal_to: 3000}
  validates :pledge_class, presence: true
  validates :current, :inclusion => {:in => [true, false]}

  after_initialize do
    if new_record?
      self.current = true
    end
  end
end
