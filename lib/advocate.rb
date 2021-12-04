class Advocate < ActiveRecord::Base
  has_many :advocate_cases
  has_many :cases, through: :advocate_cases

  has_many :advocate_states
  has_many :states, through: :advocate_states

  has_many :juniors, class_name: "Advocate", foreign_key: "senior_id"
  belongs_to :senior, class_name: "Advocate", optional: true

  POSITIONS = [:sr, :jr]

  def senior?
    position == 'sr'
  end

  def junior?
    position == 'jr'
  end

  def valid_case_for_jr(case_code)
    kase = Case.find_by(case_code: case_code)
    senior.advocate_cases.where(case_id: kase.id, status: 'rejected').blank?
  end
end
