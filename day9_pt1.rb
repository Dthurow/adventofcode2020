#!/usr/bin/env ruby
#puzzle: input is a series of numbers, new line delimited
#the rule is that for a given preamble length, each number is a sum of two of the previous numbers
#in the preamble (e.g. if preamble=5, each number is the sum of the previous 5 numbers)
#solution: find the number that does not follow the previous rule, assuming preamble=25

#read the input
inputFile = File.open("day9_input.txt")

$inputArray = inputFile.readlines

$preambleSize=25

$preambleWindow = Hash.new

def addNewNumberToPreamble(newNumber)
    if $preambleWindow.keys.length == $preambleSize+1
        #remove the first key (keys are ordered by input)
        $preambleWindow.delete($preambleWindow.keys[0])
    end

    $preambleWindow.keys.each do |key|
        $preambleWindow[key] << key+newNumber
    end
    $preambleWindow[newNumber] = []

    puts "Hash is curently #{$preambleWindow}"
end


#loop through all input lines
#for each
    #move the preamble window (remove first number sums, find sums of previous number)
    #for the given number, hunt for any sum in the preamble window 
$inputArray.each do |line|
    newNumber = line.to_i

    #move the preamble window over 
    addNewNumberToPreamble(newNumber)

    unless $preambleWindow.keys.length < $preambleSize+1
        found = false
        $preambleWindow.each_value do |arr|
            if arr.include? newNumber
                puts "found"
                found = true
                break
            end
        end

        unless found
            puts "The number #{newNumber} was not found in the preamble #{$preambleWindow}"
            break
        end
    end
    

end



