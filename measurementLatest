require 'json'

peer = ARGV[0]
a=0
output = Hash.new
output["rtt"] = Array.new
output=`sudo ping -c 3 #{peer}`
output.each_line do |line|
  rtt = line.scan(/time=(.*) /)[0]
if(rtt!=nil) then
  a+=rtt[0].to_f
end
 # output["rtt"]<< rtt[0] if (rtt != nil)
end
#p output.to_json
p a
