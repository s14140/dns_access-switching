require 'json'

peer = ARGV[0]

output = Hash.new
output["rtt"] = Array.new
output=`ping -c 3 #{peer}`
output.each_line do |line|
  rtt = line.scan(/time=(.*) /)[0]
p rtt
p output["rtt"]
  output["rtt"].push(rtt[0]) if (rtt != nil)
end
p output.to_json

