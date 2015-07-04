new_file = File.open("new_5desk.txt", "w")

File.open("5desk.txt", 'r') do |file|
  file.readlines.each do |line|
    new_file.puts line if line.chomp.size.between?(5,12)
  end
end
