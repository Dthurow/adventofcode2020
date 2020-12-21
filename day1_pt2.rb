#!/usr/bin/env ruby
#puzzle: find 3 numbers in the input that, when summed, equal 2020
#solution is those three number multiplied together

inputFile = File.open("day1_input.txt")

inputArray = inputFile.readlines
sortedArray = inputArray.sort_by(&:to_i)

for i in 0..sortedArray.length-1
    for j in (i+1)..sortedArray.length-1
        for k in (j+1)..sortedArray.length-1
            puts "values are #{i} and #{j} and #{k}"
            puts "sum is #{sortedArray[i].chomp} + #{sortedArray[j].chomp} + #{sortedArray[k].chomp} = #{sortedArray[i].to_i + sortedArray[j].to_i + sortedArray[k].to_i}"
            sum = sortedArray[i].to_i + sortedArray[j].to_i + sortedArray[k].to_i
            if sum == 2020
                puts "value is #{sortedArray[i].to_i * sortedArray[j].to_i * sortedArray[k].to_i}"
                puts "FOUND IT"
                return
            elsif sum > 2020
                puts "breaking"
                # any future combo is going to continue to be more than 2020, so short circuit
                break
            end
        end
    end
end