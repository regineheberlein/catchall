require 'active_support/all'
require 'date'
require 'csv'
require 'rubygems'
require 'recurrence'

def dates(from, to)
  dates = (from..to).to_a
  days_of_month = dates.map { |date| date.strftime('%B %d %A') }
  days_of_month
end

dates = dates(Date.today.at_beginning_of_month, Date.today.prev_month.end_of_month.advance(months: 2))

def shoot_1
  dates = ['2023-03-03']
  {
  'name' => "Mid- Atlantic Sectional",
  'time' => "12:00",
  'duration' => 4,
  'dates' => dates.map { |date| Date.parse(date).strftime('%B %d %A') }
}
end
def shoot_2
  dates = ['2023-03-03']
  {
  'name' => "Mid- Atlantic Sectional",
  'time' => "18:00",
  'duration' => 4,
  'dates' => dates.map { |date| Date.parse(date).strftime('%B %d %A') }
}
end
def shoot_3
  dates = ['2023-03-04']
  {
  'name' => "Mid- Atlantic Sectional",
  'time' => "9:00",
  'duration' => 8,
  'dates' => dates.map { |date| Date.parse(date).strftime('%B %d %A') }
}
end
def shoot_4
  dates = ['2023-03-05']
  {
  'name' => "Mid- Atlantic Sectional",
  'time' => "9:00",
  'duration' => 4,
  'dates' => dates.map { |date| Date.parse(date).strftime('%B %d %A') }
}
end
def shoot_5
  dates = Recurrence.new(every: :day, starts: '2023-03-17', until: '2023-03-18')
  {
  'name' => "NJSFAA",
  'time' => "9:00",
  'duration' => 4,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
}
end
def shoot_6
  dates = Recurrence.new(every: :day, starts: '2023-03-19', until: '2023-03-19')
  {
  'name' => "NJSFAA",
  'time' => "9:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
}
end
def member_meeting
  dates = Recurrence.new(every: :month, on: :second, weekday: :monday, repeat: 2, starts: Date.today.at_beginning_of_month)
  {
  'name' => "Member Meeting",
  'time' => "19:00",
  'duration' => 2,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
}
end
def tuesday_league
  dates = Recurrence.new(every: :week, on: :tuesday, starts: Date.today.at_beginning_of_month, until: '2023-12-31')
  {
  'name' => "Tuesday League",
  #'weekday' => "Friday",
  'time' => "18:00",
  'duration' => 4,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def wounded_warriors
  dates = Recurrence.new(every: :week, on: :wednesday, starts: Date.today.at_beginning_of_month, until: '2023-12-31')
  {
  'name' => "Wounded Warriors",
  #'weekday' => "Friday",
  'time' => "9:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def traditional_league
  dates = Recurrence.new(every: :week, on: :wednesday, starts: Date.today.at_beginning_of_month, until: '2023-12-31')
  {
  'name' => "Traditional League",
  #'weekday' => "Friday",
  'time' => "18:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def home_schoolers
  dates = Recurrence.new(every: :week, on: :friday, starts: Date.today.at_beginning_of_month, until: '2023-12-31', except: ['2023-03-17'])
  {
  'name' => "Home Schoolers",
  #'weekday' => "Friday",
  'time' => "9:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def joe_natalie
  dates = Recurrence.new(every: :week, on: :friday, starts: Date.today.at_beginning_of_month, until: '2023-12-31', except: ['2023-03-03', '2023-11-23'])
  {
  'name' => "Joe N League",
  #'weekday' => "Friday",
  'time' => "13:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def friday_nite
  dates = Recurrence.new(every: :week, on: :friday, starts: Date.today.at_beginning_of_month, until: '2023-12-15', except: ['2023-03-03', '2023-03-17', '2023-08-11', '2023-12-22', '2023-12-26'])
  {
  'name' => "Friday Nite Shoot",
  #'weekday' => "Friday",
  'time' => "19:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def jersey_girls
  dates = Recurrence.new(every: :week, on: :saturday, starts: '2023-09-16', until: '2023-12-23', except: ['2023-11-23'])
  {
  'name' => "Jersey Girls",
  #'weekday' => "Saturday",
  'time' => "12:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def navigators
  dates = Recurrence.new(every: :week, on: :saturday, starts: '2023-01-31', until: '2023-09-01', except: ['2023-03-04', '2023-11-23'])
  {
  'name' => "Navigators",
  #'weekday' => "Saturday",
  'time' => "12:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def joad
  dates = Recurrence.new(every: :week, on: :saturday, starts: '2023-01-21', until: '2023-12-23', except: ['2023-02-11', '2023-03-04', '2023-03-18'])
  {
  'name' => "JOAD",
  #'weekday' => "Saturday",
  'time' => "15:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end

@events = []
@events << member_meeting
@events << tuesday_league
@events << wounded_warriors
@events << traditional_league
@events << home_schoolers
@events << joe_natalie
@events << friday_nite
@events << jersey_girls
@events << navigators
@events << joad
@events << shoot_1
@events << shoot_2
@events << shoot_3
@events << shoot_4
@events << shoot_5
@events << shoot_6

@times = {
  "8:00" => "8 am",
  "9:00" => "9 am",
  "10:00" => "10 am",
  "11:00" => "11 am",
  "12:00" => "12 pm",
  "13:00" => "1 pm",
  "14:00" => "2 pm",
  "15:00" => "3 pm",
  "16:00" => "4 pm",
  "17:00" => "5 pm",
  "18:00" => "6 pm",
  "19:00" => "7 pm",
  "20:00" => "8 pm",
  "21:00" => "9 pm",
  "22:00" => "10 pm"
}

def slots_before_event(number)
  "," * number if number > 0
end

def index_of_event_time(time)
  @times.keys.find_index(time)
end

def event_duration(name, duration)
  "#{name}," * duration
end

#sorts events by time
def events_on_date_line(date)
  #return events_that_day(date)
  line = ["#{date},"]
  events_that_day = events_that_day(date)
  #don't return events that day for days that have no scheduled events
  unless events_that_day.blank?
    #return events_that_day(date)
   events_that_day.each_with_index do |event_that_day, index|
     current_time_index = index_of_event_time(event_that_day['time'])
     preceding_event = events_that_day[index-1] unless index-1 < 0
     preceding_time_index = index_of_event_time(preceding_event['time']) unless index-1 < 0
     subtract_preceding_event = index-1 < 0 ? 0 : preceding_time_index + preceding_event['duration']
    line << "#{slots_before_event(current_time_index-subtract_preceding_event)}#{event_duration(event_that_day['name'], event_that_day['duration'])}"
   end
  line
end
end

def events_that_day(date)
  events_that_day = []
  ordered_events = get_events(date).sort_by { |event| @times.keys.index(event['time']) }
  events_that_day << ordered_events.map { |event| event}
  events_that_day.flatten!
end

def get_events(date)
  events_selector = @events.select { |event| event if event['dates'] }
  events_compiled =
    events_selector.map do |event|
      event['dates'].map do |event_date|
    {
      'name' => event['name'],
      'time' => event['time'],
      'duration' => event['duration'],
      'date' => event_date
    }
    end
  end
  events =
    events_compiled.map do |events|
      events.map do |event|
        event if event['date'] == date
      end
    end
  events.flatten!
  events.reject!(&:blank?)
end

 CSV.open("calendar.csv", "w",
   :write_headers=> true,
   :headers => [""] + @times.values) do |row|
  dates.each do |date|
    #puts events_on_date_line(date).join('').split(',') unless events_on_date_line(date).nil?
#     #join all strings, then split on comma to make into discrete CSV fields
       if events_on_date_line(date).nil?
         row << ["#{date}"]
       else
         row << events_on_date_line(date).join('').split(',')
       end
   end
 end
