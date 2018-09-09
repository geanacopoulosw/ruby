#!/usr/bin/env ruby

first = File.readlines(ARGV.first)
i = 1

while(i < ARGV.length)
    file = File.new('infectedMalware.txt', 'w')
    a = file.write(`strings #{ARGV[i]}`)
    second = File.readlines(file)
    #third = second.each{|x|}
    if(first & second).empty?
        puts ARGV[i] + ": SAFE"
    else 
        puts ARGV[i] + ": MALWARE"
    end
    i += 1
end