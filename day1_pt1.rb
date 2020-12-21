#!/usr/bin/env ruby
#puzzle: find 2 numbers in the input that, when summed, equal 2020
#solution is those two number multiplied together
inputFile = File.open("day1_input.txt")

inputArray = inputFile.readlines

for i in 0..inputArray.length-1
    for j in (i+1)..inputArray.length-1
        puts "values are #{i} and #{j}"
        puts "sum is #{inputArray[i].chomp} + #{inputArray[j].chomp} = #{inputArray[i].to_i + inputArray[j].to_i}"
        if inputArray[i].to_i + inputArray[j].to_i == 2020
            puts "value is #{inputArray[i].to_i * inputArray[j].to_i}"
            puts "FOUND IT"
            return
        end
    end
end