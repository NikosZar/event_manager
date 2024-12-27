require 'csv'
require 'terminal-table'
file = CSV.read(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol)

date = file[:regdate]
specific_format = "%m/%d/%y %H:%M"

def convert_datetime(date, format)
  date.map {|regdate| Time.strptime(regdate, format)}
end
#date_time = Time.strptime(date, specific_format)

def count_hours(date_array)
  date_array.map(&:hour).tally.sort_by { |_, count| -count }.to_h
end

hours_count = count_hours(convert_datetime(date, specific_format))

table = Terminal::Table.new do |t|
  t.title = "Registration Hours Distribution"
  t.headings = ['Hour', 'Count']
  hours_count.each do |hour, count|
    t.add_row ["#{hour}:00", count]
  end
end

puts table