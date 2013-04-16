require 'socket'

BLOCK_SIZE = (8 * 1024)
FILENAME = 'jump.mp3'

s = UDPSocket.new
s.bind('0.0.0.0', 6666)
addr = s.recvfrom(8)[1]
p addr

s.send(File.size(FILENAME).to_s, 0, addr[3], addr[1])

File.open('jump.mp3', 'r') do |f|
  size = 0
  while b = f.read(BLOCK_SIZE)
    size += s.send(b, 0, addr[3], addr[1])
    ack = s.recvfrom(8)[0]
  end
end
s.close
