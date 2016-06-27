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
        # output0 = `ssh operator@edge01.zia.com.af "ruby measurement.rb #{peer}"`
        # output1 = `ssh operator@edge02.zia.com.af "ruby measurement.rb #{peer}"`
        # output2 = `ssh operator@edge03.zia.com.af "ruby measurement.rb #{peer}"`
        # measurement.rb: {"RTT": [32.23, 22.34, 11.12, ..]}

        # example
        edge_addrs = ["192.168.255.11", "192.168.255.12","192.168.255.13","192.168.255.14","192.168.255.15"]
        sleep(6);

        #transaction.respond!("10.0.0.80")
        transaction.respond!(edge_addrs[rand(5)])
    end

    # Default DNS handler
    otherwise do |transaction|
        transaction.passthrough!($R)
    end
end

