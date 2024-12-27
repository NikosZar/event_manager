require 'csv'

file = CSV.read(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol)

phone_data =  file[:homephone]

def number_to_string(phone_data)
  phone_data.map(&:to_s)
end

def clean_numbers(phone_numbers)
  phone_numbers.map {|number| number.gsub(/[^0-9]/, '')}
end

phone_numbers = number_to_string(phone_data)
cleaned_numbers = clean_numbers(phone_numbers)

def valid_phone_number?(number)
  return true if number.length == 10
  return true if number.length == 11 && number[0] == "1"
  false
end

def normalize_number(number)
  return number[1..10] if number.length == 11 && number[0] == "1"
  number
end

valid_numbers = cleaned_numbers.map { |number|
  valid_phone_number?(number) ? normalize_number(number) : "0000000000"
}

puts valid_numbers