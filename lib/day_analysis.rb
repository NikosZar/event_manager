require_relative 'event_data_handler'
require 'terminal-table'

times = EventDataHandler.load_data
weekday_counts = EventDataHandler.get_day_distribution(times)

# Print results
weekday_names = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
weekday_counts.each do |day_num, count|
  puts "#{weekday_names[day_num]}: #{count} registrations"
end

table = Terminal::Table.new do |t|
  t.title = "Registration Day Distribution"
  t.headings = ['Day', 'Count', 'Distribution']
  t.style = { border_x: "=", border_i: "x" }

  weekday_counts.each do |day_num, count|
    percentage = (count.to_f / weekday_counts.values.sum * 100).round(1)
    t.add_row [
      weekday_names[day_num].ljust(9),
      count.to_s.rjust(5),
      "#{("#" * (percentage/2)).ljust(50)} #{percentage}%"
    ]
  end
end

puts table