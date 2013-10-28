require 'test_helper'

class UserTest < ActiveSupport::TestCase
	# test "the truth" do
	#   assert true
	# end

	test "Has one resource profile" do
		assert User.first.resource_profile.count == 1
	end
end
