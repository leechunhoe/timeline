class Application < ActiveRecord::Base
	
	def self.month_selection
    	Time.now
	end
	
	def self.month_selection_day_count
    	Time.days_in_month(month_selection.month, month_selection.year)
	end
	
	private
	def self.is_today(day)
		is_same_year_same_month(month_selection, Time.now) && day == Time.now.day 
	end
	
	private	
	def self.is_same_year_same_month(date1, date2)
		date1.year == date2.year && date1.month == date2.month
	end
	
	private	
	def self.month_of_date1_is_later_than_date2(date1, date2)
		(date1.year == date2.year && date1.month > date2.month) || date1.year > date2.year 
	end
	
	def self.is_start_date(event, day)
		(is_same_year_same_month(month_selection, event.start_date) && event.start_date.day == day) || (month_of_date1_is_later_than_date2(Application.month_selection, event.start_date) && !month_of_date1_is_later_than_date2(Application.month_selection, event.end_date) && day == 1)
	end
	
	def self.is_in_duration(event, day)
		this_date = Date.new(month_selection.year, month_selection.month, day)
		
		this_date > event.start_date && this_date <= event.end_date
	end
	
	def self.duration_in_selected_month(event)
		if is_same_year_same_month(event.end_date, Application.month_selection)
			end_date = event.end_date.day
		else
			end_date = Application.month_selection_day_count 
		end
		
		if is_same_year_same_month(event.start_date, Application.month_selection)
			start_date = event.start_date.day
		else
			start_date = 1
		end
		
		end_date - start_date + 1
	end
end