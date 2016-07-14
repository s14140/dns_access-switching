#!/usr/bin/env ruby

require 'rubygems'
require 'rubydns'

$R = Resolv::DNS.new
Name = Resolv::DNS::Name
IN = Resolv::DNS::Resource::IN

RubyDNS::run_server(:listen => [[:udp, "0.0.0.0", 53]]) do
    # For this exact address record, return an IP address
    match("edge.zia.com.af", IN::A) do |transaction|
        peer = transaction.options[:peer]

        # Ask the edge computers to check RTT to the client peer
         output0 = `ssh pi@172.16.1.248 "ruby /home/pi/Desktop/platform/measurement.rb #{peer}"`
        output1 = `ssh pi@172.16.2.13 "ruby /home/pi/Desktop/platform/measurement.rb #{peer}"`
        edge1= output0.to_f
	edge2= output1.to_f
	p edge1
        # measurement.rb: {"RTT": [32.23, 22.34, 11.12, ..]}
        if edge1<= edge2 then
            edge_addrs=["172.16.1.248"]
        else
            edge_addrs=["172.16.2.13"]
        end
        # example
       
        sleep(6);

        #transaction.respond!("10.0.0.80")
        transaction.respond!(edge_addrs[rand(5)])
    end

    # Default DNS handler
    otherwise do |transaction|
        transaction.passthrough!($R)
    end
end
