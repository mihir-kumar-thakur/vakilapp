class State < ActiveRecord::Base
  has_many :advocates, through: :advocate_states
  has_many :cases
end
