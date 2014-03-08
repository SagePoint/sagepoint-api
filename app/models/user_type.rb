#  1 | Resource
#  2 | Manager
#  3 | Executive
#  4 | Admin
#  5 | HR Admininstrator
#  6 | Skillweb Editor

class UserType < ActiveRecord::Base
  has_and_belongs_to_many :users
  
end