class UserAlias < ActiveRecord::Base
  serialize :alias_hash
  belongs_to :user
  attr_protected :id,:user_id

end
