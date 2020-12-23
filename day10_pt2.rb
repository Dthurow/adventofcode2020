#!/usr/bin/env ruby
#puzzle: input is a series of numbers, new line delimited, representing the specific output joltage of a given joltage adaptor
#to chain adapters together, they must be within 3 jolts difference (e.g. joltage adapter with output 3 can then be plugged into one with 4, 5, or 6 output)
# and the first adaptor must have a lower output joltage than the second one.
# use all the joltage adapters, starting with a 0 joltage output (the charging outlet)
#to the device you want to charge (which is always 3 more than the largest joltage adapter given)
#solution:
#count the number of possible ways to connect adapters

#test input 1 the total number of arrangements that connect the charging outlet to your device is 8.
#test input 2 the total number of arrangements that connect the charging outlet to your device is 19208.

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

#have to have a cache for the official input because otherwise its too much data
#no cache recursion works for testinputs 1 and 2 but freezes VSCode on real input
$cachingHash = Hash.new

#recursion!
def NumberOfSplits(startingIndex)
    puts "Starting new call with index #{startingIndex}"
    #work to base: step through array until you find a split point, where you can choose which adapter you want to use next
    #recursive call: the number of total arrangements will be the sum of the number of arrangements if you chose one or the other option at each split point
    #base case: once you hit the end of the array, return 1

    if $cachingHash.has_key? startingIndex
        puts "using cache"
        return $cachingHash[startingIndex]
    end

    numToReturn = 0

    for i in startingIndex..$inputArray.length-4
        puts "testing at index #{i}, checking #{$inputArray[i+2]} against #{$inputArray[i]}"
        if $inputArray[i+2] - $inputArray[i] <= 3
            #have 2 options at least
            puts "Found two options, doing recursion call"
            numToReturn += NumberOfSplits(i+1) + NumberOfSplits(i+2)

            if $inputArray[i+3] - $inputArray[i] <= 3
                #have 3 options
                puts "Found a third option, doing recursion call"
                numToReturn += NumberOfSplits(i+3)
            end
            $cachingHash[startingIndex] = numToReturn
            return numToReturn
        end

    end

    puts "made it to the end, returning 1"
    $cachingHash[startingIndex] = 1
    return 1


end

puts "final value is #{NumberOfSplits(0)}"