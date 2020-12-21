#!/usr/bin/env ruby
#puzzle: for each line, decide if the password is valid. each line is of the format:
# {range} {character} : {password}
#the given character must appear within the password a number of times specified by the range to be allowed
#solution is the number of valid passwords

inputFile = File.open("day2_input.txt")

inputArray = inputFile.readlines

validpasswordcount = 0

for line in inputArray
    lineSplit = line.split(/[: -]/)
    sum = 0
    lineSplit[lineSplit.length - 1].each_char do |c|
        if c == lineSplit[2]
            sum += 1 #found the given char
        end
        if sum > lineSplit[1].to_i
            #gone over max allowed count, invalid!
            break
        end
    end

    #if the sum of the given char is within the range given (inclusive), its valid
    if sum >= lineSplit[0].to_i and sum <= lineSplit[1].to_i
        validpasswordcount += 1
    end

end

puts "Final valid number of passwords is #{validpasswordcount}"