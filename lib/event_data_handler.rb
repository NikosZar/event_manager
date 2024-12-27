# Create a new file for shared functionality
require 'csv'
require 'time'

module EventDataHandler
  def self.load_data(file_path = 'event_attendees.csv')
    file = CSV.read(file_path, headers: true, header_converters: :symbol)
    date = file[:regdate]
    specific_format = "%m/%d/%y %H:%M"
    convert_datetime(date, specific_format)
  end


  def self.convert_datetime(date, specific_format)
    date.map { |regdate| Time.strptime(regdate, specific_format) }
  end

  def self.get_weekdays(times)
    weekday_names = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    times.map { |time| weekday_names[time.wday] }
  end

  def self.get_day_distribution(times)
    times.map(&:wday).tally.sort.to_h
  end
end