require 'csv'
require 'sunlight/congress'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode zipcode
  zipcode.to_s.rjust(5, "0")[0...5]
end

def legislators_to_s legislators
  legislators_names = legislators.collect do |legislator|
    "#{legislator.first_name} #{legislator.last_name}"
  end
end

def legislators_by_zipcode zipcode
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
  legislators_to_s(legislators).join(", ")
end

def main
  puts "EventManager Initialized"
  template_letter = File.read "form_letter.html"

  contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
  contents.each do |row|
    name = row[:first_name]
    zipcode = clean_zipcode(row[:zipcode])
    legislators = legislators_by_zipcode zipcode

    personal_letter = template_letter.gsub('FIRST_NAME',name)
    personal_letter.gsub!('LEGISLATORS',legislators)

    puts personal_letter
  end
end
main
