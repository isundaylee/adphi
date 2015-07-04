class Group < ActiveRecord::Base
  has_many :memberships, dependent: :destroy

  validates :name, presence: true, length: {minimum: 1, maximum: 16}
end
