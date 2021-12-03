class Advocate < ActiveRecord::Base
  has_many :advocate_cases
  has_many :cases, through: :advocate_cases
  has_many :states

  has_many :juniors, class_name: "Advocate", foreign_key: "senior_id"
  belongs_to :senior, class_name: "Advocate", optional: true
end
