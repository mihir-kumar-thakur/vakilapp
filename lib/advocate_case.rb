class AdvocateCase < ActiveRecord::Base
  belongs_to :advocate
  belongs_to :case

  STATUS = ['accepted', 'rejected']
end
