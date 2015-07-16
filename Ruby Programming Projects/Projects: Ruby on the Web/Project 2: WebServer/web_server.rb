require 'socket'
require 'json'

server = TCPServer.open(2000)
loop do
  client = server.accept
  request = client.read_nonblock(256)

  request_header, request_body = request.split("\r\n\r\n",2)
  path = request.split[1][1..-1]
  method = request.split[0].upcase

  if File.exist?(path)
    response_body = File.read(path)
    client.puts "HTTP/1.0 200 OK\r\nContent-type:text/html\r\n\r\n"
    if method == 'GET'
      client.puts response_body
    elsif method == 'POST'
      client.puts request.split("Content-Length: ")
      params = JSON.parse(request_body)
      file = File.read("thanks.html")
      new_info = "<li>Name: #{params['viking']['name']}</li><li>Email: #{params['viking']['email']}</li>"
      client.puts file.gsub("<% yield %>", new_info)
    end
  else
    client.puts "HTTP/1.0 404 Not Found\r\n\r\n"
    client.puts "404 Error, File Could not be found"
  end
  client.close
end
