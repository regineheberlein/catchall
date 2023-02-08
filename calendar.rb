require 'active_support/all'
require 'date'
require 'csv'
require 'rubygems'
require 'recurrence'

member_meeting = Recurrence.new(every: :month, on: :second,  weekday: :monday, repeat: 6)
member_meeting_dates = member_meeting.events.each {|date| date.to_s }

@events = [
{
'name' => "Tuesday League",
'weekday' => "Tuesday",
'time' => "18:00",
'duration' => 4
},
{
'name' => "Wounded Warriors",
'weekday' => "Wednesday",
'time' => "9:00",
'duration' => 3
},
{
'name' => "Traditional Leage",
'weekday' => "Wednesday",
'time' => "18:00",
'duration' => 3
},
{
'name' => "Home Schoolers",
'weekday' => "Friday",
'time' => "9:00",
'duration' => 3
},
{
'name' => "Joe N League",
'weekday' => "Friday",
'time' => "13:00",
'duration' => 3
},
{
'name' => "Friday Nite Shoot",
'weekday' => "Friday",
'time' => "19:00",
'duration' => 3
},
{
'name' => "Jersey Girls",
'weekday' => "Saturday",
'time' => "12:00",
'duration' => 3
},
{
'name' => "JOAD",
'weekday' => "Saturday",
'time' => "15:00",
'duration' => 3
},
{
'name' => "single_test_event",
'time' => "8:00",
'duration' => 1,
'date' => "February 01"
},
{
'name' => "Member Meeting",
'time' => "19:00",
'duration' => 2,
'dates' => member_meeting_dates
}
]

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

def dates(from, to)
  dates = (from..to).to_a
  days_of_month = dates.map { |date| date.strftime('%B %d %A') }
  days_of_month
end

def time_slot(time)
  @times.find_index(time)
end

def slots_before_event(number)
  "," * number if number > 0
end

def index_of_event_time(current_time)
  @times.find_index(current_time)
end

def event_duration(name, duration)
  "#{name}," * duration
end

def events_on_date_line(date)
  line = ["#{date},"]
  events = events_that_day(date)
  #don't return events that day for days that have no scheduled events
  unless events.blank?
    events.each_with_index do |event, index|
      current_time_index = index_of_event_time(event['time'])
      preceding_event = events[index-1] unless index-1 < 0
      preceding_time_index = index_of_event_time(preceding_event['time']) unless index-1 < 0
      subtract_preceding_event = index-1 < 0 ? 0 : preceding_time_index + preceding_event['duration']
      line << "#{slots_before_event(current_time_index-subtract_preceding_event)}#{event_duration(event['name'], event['duration'])}"
      end
    line
  end
end

def all_events(date)
  recurring_events_by_interval(date) + single_events(date) + recurring_events_grouped_by_weekday(date)
end

def single_events(date)
  @events.select { |event| event['date'] if (date.split[0..1].join(' ') == event['date'] ) }
end

#single events need to be fed in here
def events_that_day(date)
  events_that_day = []
  ordered_events = all_events(date).sort_by { |event| event.index(event['time']) }
  events_that_day << ordered_events.map { |event| event}
  events_that_day.flatten!
end

def recurring_events_grouped_by_weekday(date)
  events_by_weekday = []
  @events.map { |event| events_by_weekday << event if (date.split.last == event['weekday'])}
  events_by_weekday
end

def recurring_events_by_interval(date)
  interval_events_selector = @events.select { |event| event if event['dates'] }
  interval_events_compiled =
    interval_events_selector[0]['dates'].map do |interval_event|
    {
      'name' => interval_events_selector[0]['name'],
      'time' => interval_events_selector[0]['time'],
      'duration' => interval_events_selector[0]['duration'],
      'date' => interval_event.strftime('%B %d')
    }
  end
  interval_events = interval_events_compiled.map do |event|
      event if date.split[0..1].join(' ') == event['date']
    end
  interval_events.reject!(&:blank?)
end

dates = dates(Date.today.at_beginning_of_month, Date.today.prev_month.end_of_month.advance(months: 6))

CSV.open("calendar.csv", "w",
  :write_headers=> true,
  :headers => [""] + @times) do |row|
    dates.each do |date|
      #join all strings, then split on comma to make into discrete CSV fields
      if events_on_date_line(date).nil?
        row << ["#{date}"]
      else
        row << events_on_date_line(date).join('').split(',')
      end
    end

end
