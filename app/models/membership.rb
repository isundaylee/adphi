class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :brother

  validates :group, presence: true
  validates :brother, presence: true, uniqueness: {scope: :group_id}
end
