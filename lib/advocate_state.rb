class AdvocateState < ActiveRecord::Base
  belongs_to :state
  belongs_to :advocate
end
