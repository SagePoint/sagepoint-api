class Project < ActiveRecord::Base
  has_many :tasks
  belongs_to :employer
  
  #belongs_to :location, :through => :address  
  
#  belongs_to :manager, :through => :resource_profile

  scope :past_day, where("date(created_at) >= DATE(DATE_SUB(NOW(),INTERVAL 1 DAY))")

end