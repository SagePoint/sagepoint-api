module ApplicationHelper

	def _log(msg, type='info')
		Rails.logger.send("#{type}","APPLICATION: #{msg}")
	end
end
