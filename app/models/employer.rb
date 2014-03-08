class Employer < ActiveRecord::Base
  has_many :users
  has_many :projects
  has_many :tasks
	has_many :resource_profiles

  scope :past_day, where("date(created_at) >= DATE(DATE_SUB(NOW(),INTERVAL 1 DAY))")

end
