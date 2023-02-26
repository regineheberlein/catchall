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

dates = dates(Date.today.at_beginning_of_month, Date.today.prev_month.end_of_month.advance(months: 3))

def member_meeting
  dates = Recurrence.new(every: :month, on: :second,  weekday: :monday, repeat: 2)
  {
  'name' => "Member Meeting",
  'time' => "19:00",
  'duration' => 2,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
}
end
def tuesday_league
  dates = Recurrence.new(every: :week, on: :tuesday, until: '2023-12-31')
  {
  'name' => "Tuesday League",
  #'weekday' => "Friday",
  'time' => "18:00",
  'duration' => 4,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def wounded_warriors
  dates = Recurrence.new(every: :week, on: :wednesday, until: '2023-12-31')
  {
  'name' => "Wounded Warriors",
  #'weekday' => "Friday",
  'time' => "9:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def traditional_league
  dates = Recurrence.new(every: :week, on: :wednesday, until: '2023-12-31')
  {
  'name' => "Traditional League",
  #'weekday' => "Friday",
  'time' => "18:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def home_schoolers
  dates = Recurrence.new(every: :week, on: :friday, until: '2023-12-31')
  {
  'name' => "Home Schoolers",
  #'weekday' => "Friday",
  'time' => "9:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def joe_natalie
  dates = Recurrence.new(every: :week, on: :friday, until: '2023-12-31', except: ['2023-11-23'])
  {
  'name' => "Joe N League",
  #'weekday' => "Friday",
  'time' => "13:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def friday_nite
  dates = Recurrence.new(every: :week, on: :friday, until: '2023-12-15', except: ['2023-03-03', '2023-03-17', '2023-08-11', '2023-12-22', '2023-12-26'])
  {
  'name' => "Friday Nite Shoot",
  #'weekday' => "Friday",
  'time' => "19:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def jersey_girls
  dates = Recurrence.new(every: :week, on: :saturday, until: '2023-12-23', except: ['2023-11-23'])
  {
  'name' => "Jersey Girls",
  #'weekday' => "Saturday",
  'time' => "12:00",
  'duration' => 3,
  'dates' => dates.map { |date| date.strftime('%B %d %A') }
  }
end
def joad
  dates = Recurrence.new(every: :week, on: :saturday, until: '2023-12-23', except: ['2023-02-11', '2023-03-04'])
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
@events << joad

@times = [
  "8:00",
  "9:00",
  "10:00",
  "11:00",
  "12:00",
  "13:00",
  "14:00",
  "15:00",
  "16:00",
  "17:00",
  "18:00",
  "19:00",
  "20:00",
  "21:00",
  "22:00"
]

def slots_before_event(number)
  "," * number if number > 0
end

def index_of_event_time(time)
  @times.find_index(time)
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
  #get_events(date)
  events_that_day = []
  ordered_events = get_events(date).sort_by { |event| event.index(event['time']) }
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
   :headers => [""] + @times) do |row|
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
