class Case < ActiveRecord::Base
  has_many :advocate_cases

  has_many :advocates, through: :advocate_cases
  belongs_to :state

  STATES = [:open, :accepted, :rejected]
end
