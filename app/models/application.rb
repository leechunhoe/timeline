class Application < ActiveRecord::Base
	
	def self.month_selection
    	Time.now
	end
	
	def self.isToday(day)
		month_selection.year == Time.now.year && month_selection.month == Time.now.month && day == Time.now.day 
	end
end