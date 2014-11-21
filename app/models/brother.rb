class Brother < ActiveRecord::Base
  scope :current, -> { where(current: true) }

  enum position: [
    :president,
    :vice_president,
    :treasurer,
    :secretary,
    :house_manager,
    :kitchen_manager,
    :social_chairman,
    :rush_chairman,
    :pledge_trainer,
    :brotherhood,
    :academic_chairman,
    :athletic_chairman,
    :alumni_relations_chairman,
    :community_relations_chairman,
    :historian,
    :fraternity_representative,
    :society_representative,
    :critic
  ]

  POSITION_NAMES = [
    "President",
    "Vice President",
    "Treasurer",
    "Secretary",
    "House Manager",
    "Kitchen Manager",
    "Social Chairman",
    "Rush Chairman",
    "Pledge Trainer",
    "Brotherhood",
    "Academic Chairman",
    "Athletic Chairman",
    "Alumni Relations Chairman",
    "Community Relations Chairman",
    "Historian",
    "Fraternity Representative",
    "Society Representative",
    "Critic"
  ]

  belongs_to :pledge_class

  has_many :shortlogs, dependent: :destroy
  has_many :meetings, foreign_key: 'creator_id', dependent: :destroy
  has_many :attendences, dependent: :destroy

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
