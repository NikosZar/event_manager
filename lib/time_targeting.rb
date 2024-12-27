require_relative 'event_data_handler'
require 'terminal-table'

# Use the shared functionality
times = EventDataHandler.load_data
hour_counts = times.map(&:hour).tally.sort_by { |_, count| -count }.to_h

def count_hours(date_array)
  date_array.map(&:hour).tally.sort_by { |_, count| -count }.to_h
end

hours_count = count_hours(times)

table = Terminal::Table.new do |t|
  t.title = "Registration Hours Distribution"
  t.headings = ['Hour', 'Count']
  hours_count.each do |hour, count|
    t.add_row ["#{hour}:00", count]
  end
end

puts table