class Brother < ActiveRecord::Base
  belongs_to :pledge_class

  validates :name, presence: true, length: {minimum: 1, maximum: 100}
  validates :year, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1900, less_than_or_equal_to: 3000}
  validates :pledge_class, presence: true
  validates :current, :inclusion => {:in => [true, false]}

  after_initialize do
    if new_record?
      self.current = true
    end
  end
end
