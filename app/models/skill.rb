class Skill < ActiveRecord::Base
	has_many :skill_requirements
	has_many :skill_similars
	has_many :skill_ratings
	has_many :skill_keys
	has_many :skill_aliases
	has_and_belongs_to_many :metadatum
end
