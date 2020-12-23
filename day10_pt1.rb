#!/usr/bin/env ruby
#puzzle: input is a series of numbers, new line delimited, representing the specific output joltage of a given joltage adaptor
#to chain adapters together, they must be within 3 jolts difference (e.g. joltage adapter with output 3 can then be plugged into one with 4, 5, or 6 output)
# and the first adaptor must have a lower output joltage than the second one.
# use all the joltage adapters, starting with a 0 joltage output (the charging outlet)
#to the device you want to charge (which is always 3 more than the largest joltage adapter given)
#solution:
#count the number of connectiongs that have a 1, 2 or 3 joltage difference
#Find the number of 1-jolt differences multiplied by the number of 3-jolt differences

#test input 1 should have 7 differences of 1 jolt and 5 differences of 3 jolts.
#test input 2 should have 22 differences of 1 jolt and 10 differences of 3 jolts.

#read the input
inputFile = File.open("day10_input.txt")

$inputArray = inputFile.readlines

$inputArray.map!(&:to_i)
$inputArray.sort!

differencesHash = Hash.new

#start at 0
$inputArray.unshift(0)

#end at highest val + 3
$inputArray << $inputArray[$inputArray.length-1]+3


$inputArray.each_with_index do |num, i|
    if i > 0
        diff = num - $inputArray[i-1]
        unless differencesHash.has_key? diff
            differencesHash[diff] = 0
        end
        differencesHash[diff] += 1
    end
end

puts "final hash is #{differencesHash} and multiplied together its #{differencesHash[1] * differencesHash[3]}"