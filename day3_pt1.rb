#!/usr/bin/env ruby
#puzzle: input is a "map" showing open ground and trees (denoted by #). starting in the top left
#going right 3 and down 1, find how many trees you'd hit. The pattern in the "map" repeats to the 
#right as many times as it takes until you reach the "bottom"
#solution is how many trees (#'s) would you hit on the way down the slope

inputFile = File.open("day3_input.txt")

inputArray = inputFile.readlines

hitTrees = 0
rightIndex = 0

for line in inputArray
    #puts "checking location and it is a '#{line[rightIndex]}'"
    if line[rightIndex] == "#"
        #ouch
        hitTrees += 1
    end
    lineCopy = line
    lineCopy[rightIndex] = 'O'
    puts lineCopy

    #increase the index by 3. if you reach the far right,
    #just loop around with the power of mod
    rightIndex = (rightIndex + 3) % (line.length-1)
    #puts "right index is now #{rightIndex}"
end

puts "Final tally of hit trees: #{hitTrees}"