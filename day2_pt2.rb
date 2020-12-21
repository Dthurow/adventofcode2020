#!/usr/bin/env ruby
#puzzle: for each line, decide if the password is valid. each line is of the format:
# {first number}-{second number} {character} : {password}
#the given character must be in either the first number index (1-indexed), or the second number inded, but not both (exclusive or)
#solution is the number of valid passwords

inputFile = File.open("day2_input.txt")

inputArray = inputFile.readlines

validpasswordcount = 0

for line in inputArray
    lineSplit = line.split(/[: -]/)   
    password = lineSplit[lineSplit.length-1]
    char = lineSplit[2]
    charOne = password[lineSplit[0].to_i-1]
    charTwo = password[lineSplit[1].to_i-1]
    puts "checking if #{charOne} or #{charTwo} contain #{char}"

    #exclusive or the long winded way
    if (charOne == char or charTwo == char) and not (charOne == char and charTwo == char)
        validpasswordcount +=1
    end

end

puts "Final valid number of passwords is #{validpasswordcount}"