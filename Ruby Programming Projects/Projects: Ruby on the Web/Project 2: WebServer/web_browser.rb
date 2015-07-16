require 'socket'
require 'json'

host = 'localhost'
port = 2000
vikings_hash = Hash.new { |hash, key| hash[key] = Hash.new}

input = ""
until input == "POST" || input == "GET"
  puts "GET or POST?"
  input = gets.chomp
  puts input
end

if input == "GET"
  request = "GET /index.html HTTP/1.0"
else
  puts "Name of viking?"
  name = gets.chomp
  puts name
  puts "Email of  viking?"
  email = gets.chomp
  puts email
  vikings_hash[:viking][:name] = name
  vikings_hash[:viking][:email] = email
  body = vikings_hash.to_json
  request = "POST /thanks.html HTTP/1.0\r\nContent-Length: #{vikings_hash.to_json.length}\r\n\r\n#{body}"
end

socket = TCPSocket.open(host,port)
socket.print(request)
while line = socket.gets
  puts line.chomp
end
