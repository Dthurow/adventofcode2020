#!/usr/bin/env ruby
#puzzle: input is a series of numbers, new line delimited
#the rule is that for a given preamble length, each number is a sum of two of the previous numbers
#in the preamble (e.g. if preamble=5, each number is the sum of the previous 5 numbers)
#given a number that does not follow these rules, find a continguous set of at least two numbers in the input which sum to the invalid number
#solution: find the continguous set, and sum together the smallest and largest number in this contiguous range

#read the input
inputFile = File.open("day9_input.txt")

$inputArray = inputFile.readlines

$invalidNumber = 90433990
$foundRangeStart = 0
$foundRangeEnd = 0


for i in 0..$inputArray.length-2
    found = false
    curSum = $inputArray[i].to_i
    for j in i+1..$inputArray.length-1
        curSum += $inputArray[j].to_i
        puts "range is #{i} to #{j} and sum is #{curSum}"
        if curSum > $invalidNumber
            puts "Current sum #{curSum} is greater than invalid num, so short circuit"
            break
        elsif curSum == $invalidNumber
            puts "Found the range! #{i} to #{j}"
            $foundRangeStart=i
            $foundRangeEnd=j
            found = true
            break
        end
    end
    if found
        break
    end
end


maxVal = 0
minVal = 0

for i in $foundRangeStart..$foundRangeEnd
    if $inputArray[i].to_i > maxVal
        maxVal = $inputArray[i].to_i 
    end
    if $inputArray[i].to_i < minVal or minVal == 0
        minVal = $inputArray[i].to_i 
    end
    puts "cur min #{minVal} cur max #{maxVal}"
end

puts "#{maxVal} + #{minVal} = #{maxVal + minVal}"