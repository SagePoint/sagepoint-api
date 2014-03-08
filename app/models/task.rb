class Task < ActiveRecord::Base
  self.table_name = "task_profiles"

  belongs_to :project
  belongs_to :employer
  #belongs_to :location, :through => :address  
  #belongs_to :manager, :through => :user
  
  scope :past_day, where("date(created_at) >= DATE(DATE_SUB(NOW(),INTERVAL 1 DAY))")
  
end