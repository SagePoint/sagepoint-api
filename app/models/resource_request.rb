class ResourceRequest < ActiveRecord::Base
  belongs_to :requesting_manager, :class_name => "ResourceProfile", :foreign_key => "requesting_manager_id"
  belongs_to :requesting_employer, :class_name => "Employer", :foreign_key => "requesting_employer_id"
  belongs_to :task
  belongs_to :resource_profile
  attr_protected :id,:resource_profile_id,:task_profile_id
  scope :past_day, where("date(created_at) >= DATE(DATE_SUB(NOW(),INTERVAL 1 DAY))")
  scope :approved_past_day, where("approved_date >= DATE(DATE_SUB(NOW(),INTERVAL 1 DAY))")
end
