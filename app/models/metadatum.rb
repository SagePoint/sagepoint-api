class Metadatum < ActiveRecord::Base
	self.table_name = "metadatum"
	has_and_belongs_to_many :skills
end
