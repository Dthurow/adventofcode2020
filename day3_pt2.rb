#!/usr/bin/env ruby
#puzzle: input is a "map" showing open ground and trees (denoted by #). starting in the top left
#going right X and down Y, find how many trees you'd hit. The pattern in the "map" repeats to the 
#right as many times as it takes until you reach the "bottom"
#The X and Y values are as follows:
# Right 1, down 1.
# Right 3, down 1.
# Right 5, down 1.
# Right 7, down 1.
# Right 1, down 2.
#solution is how many trees (#'s) would you hit on the way down the slope for each X, Y values, multiplied together

inputFile = File.open("day3_input.txt")

inputArray = inputFile.readlines

multipliedFinal = 1

stepIncrements = [
    [1,1],
    [3,1],
    [5,1],
    [7,1],
    [1,2]
]

stepIncrements.each do |steps|
    rightStep=steps[0]
    downStep=steps[1]
    
    #reset index values and hit trees for a new round
    lineIndex=0
    rightIndex=0
    hitTrees=0

    while lineIndex < inputArray.length
        line=inputArray[lineIndex]

        if line[rightIndex] == "#"
            #ouch
            hitTrees += 1
        end
    
        #increase the indices by given amounts. if you reach the far right,
        #just loop around with the power of mod
        rightIndex = (rightIndex + rightStep) % (line.length-1)
        lineIndex = lineIndex + downStep
    end

    #with the given found number of hit trees, display it for debuggin and multiply it out
    puts "For right #{rightStep}, down #{downStep}, hit #{hitTrees} trees"
    multipliedFinal = multipliedFinal * hitTrees

end

puts "final multiplied value is #{multipliedFinal}"




