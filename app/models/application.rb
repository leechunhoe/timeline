class Application < ActiveRecord::Base
	
	def self.month_selection
    	Time.now
	end
	
	def self.month_selection_day_count
    	Time.days_in_month(month_selection.month, month_selection.year)
	end
	
	def self.is_today(day)
		month_selection.year == Time.now.year && month_selection.month == Time.now.month && day == Time.now.day 
	end
	
	def self.is_start_date(event, day)
		(event.start_date.year == Application.month_selection.year && event.start_date.month == Application.month_selection.month && event.start_date.day == day) || !(event.start_date.year >= Application.month_selection.year && event.start_date.month >= Application.month_selection.month) && (event.end_date.year >= Application.month_selection.year && event.end_date.month >= Application.month_selection.month && day == 1)
	end
	
	def self.duration_in_selected_month(event)
		if event.end_date.year == Application.month_selection.year && event.end_date.month == Application.month_selection.month
			(event.end_date-event.start_date).to_i/86400+1
		elsif event.end_date.year > Application.month_selection.year || (event.end_date.year == Application.month_selection.year && event.end_date.month > Application.month_selection.month)
			Application.month_selection_day_count-event.start_date.day+1
		else
			1
		end
	end
end