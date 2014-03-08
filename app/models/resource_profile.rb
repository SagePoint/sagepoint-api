class ResourceProfile < ActiveRecord::Base
#  has_many :skill_ratings
#  has_many :match_results
#  has_many :events
#  has_many :task_assignments
  has_many :tasks
  has_many :projects
  has_many :resource_profiles, :foreign_key => "manager_id"
  belongs_to :employer
#  belongs_to :contact_profile
#  belongs_to :pay_type
  belongs_to :user
#  belongs_to :title
# belongs_to :division
#  has_many :match_logs
  belongs_to :manager, :class_name => "ResourceProfile"
  #has_and_belongs_to_many :roles
  has_many :resource_requests

  scope :past_day, where("date(created_at) >= DATE(DATE_SUB(NOW(),INTERVAL 1 DAY))")
end
