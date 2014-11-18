class PledgeClass < ActiveRecord::Base
  has_many :brothers

  validates :name, presence: true, length: {minimum: 1, maximum: 50}
  validates :year, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1900, less_than_or_equal_to: 3000}
end
