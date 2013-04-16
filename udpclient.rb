require 'socket'

BLOCK_SIZE = (8 * 1024)

s = UDPSocket.new
s.connect('67.214.222.195', 6666)
s.send('hi', 0)

recvlen = s.recvfrom(8)[0].to_i
p 'receiving: ' + recvlen.to_s + ' bytes'

currlen = 0
File.open('test.mp3', 'w') do |f|
  while b = s.recvfrom(BLOCK_SIZE)[0]
    currlen += f.write(b)
    s.send(':)', 0)
    break if currlen >= recvlen
  end
end
