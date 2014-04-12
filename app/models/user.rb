class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  include TokenAuthenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # before_save :ensure_authentication_token!

  has_one :resource_profile
  # has_one :user_alias
  belongs_to :employer
  # has_many :drilldowns
  # has_many :skill_suggestions
  # has_many :reports
  # has_many :expiring_links
  has_and_belongs_to_many :user_types
  # has_and_belongs_to_many :roles

  # has_many :certs
  # has_many :clearances
  # has_many :educations
  # serialize :tos_accepted, Hash
  # attr_protected :id,:employer_id,:is_enabled

  scope :enabled, where(:is_enabled=>true)
  scope :active, where("current_sign_in_at > ?",(Time.now-6.month))
  scope :daily_active, where("date(current_sign_in_at) >= DATE(DATE_SUB(NOW(),INTERVAL 1 DAY))") #TODO verify mysql time zone + production time zones align


  # def valid_user(user_types)
  #   return false unless user_types
  #   (user_types = [user_types]) unless user_types.is_a?(Array)
  #   user_types.each{|user_type|
  #       return true unless self.user_types.select{|owned_types|owned_types.code == user_type }.empty?
  #   }
  #   return false
  # end

  # def active_user(user_types=nil)
  #   #TODO replace all calls to active_user  to valid user instead. This is necessary because active user is actually active portal, so the permissions should not rely on the active user
  #   return  self.active_user_code unless user_types
  #   (user_types = [user_types]) unless user_types.is_a?(Array)
  #   user_types.each{|user_type|
  #     return user_type if self.active_user_code == user_type
  #   }
  #   return false
  # end

end
