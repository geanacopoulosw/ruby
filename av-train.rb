#!/usr/bin/env ruby

workingDir = Dir.pwd
output = ARGV[2]
malware = File.new('malware.txt', 'w')
safe = File.new('safe.txt', 'w')
signatures = File.new(output, 'w')

if ARGV.length != 3
    abort "Invalid entry you need 2 dir followed by an output file"
end

Dir.chdir(ARGV[0])

Dir.foreach(ARGV[0]) do |file|
    next if file == '.' or file == '..'
    word = File.read(file)
    malware.write(`strings #{file}`)
end

Dir.chdir(ARGV[1])

Dir.foreach(ARGV[1]) do |file|
    next if file == '.' or file == '..'
    word = File.read(file)
    safe.write(`strings #{file}`)
end

Dir.chdir(workingDir)

malwareLines = File.readlines('malware.txt')
safeLines = File.readlines('safe.txt')
mL = malwareLines.uniq
sL = safeLines.uniq
aL = mL - sL
sigL = aL.each{|x|}

i = 0
while (i < aL.length)
    signatures.write(sigL[i])
    i += 1
end