#!/usr/bin/env ruby
#puzzle: input is a series of "boarding passes". each boarding pass is a series of
#F's and B's followed by L's and R's
#The first 7 characters will either be F or B; 
#these specify exactly one of the 128 rows on the plane (numbered 0 through 127). 
#Each letter tells you which half of a region the given seat is in. 
#Start with the whole list of rows; 
#the first letter indicates whether the seat is in the front (0 through 63) or the back (64 through 127). 
#The next letter indicates which half of that region the seat is in, 
#and so on until you're left with exactly one row.
#The last three characters will be either L or R; 
#these specify exactly one of the 8 columns of seats on the plane (numbered 0 through 7)
# seat ID is found by equation: ({row} * 8) + {column}
#solution: the highest seat ID on a boarding pass

inputFile = File.open("day5_input.txt")

inputArray = inputFile.readlines

def calculateSeatID (values)
    rowNum = 0
    columnNum = 0
    
    #calculate the row number
    startVal=0
    endVal = 127

    #get it down to only two possible numbers
    values[0,7].each_char do |c|
        #puts "#{startVal}, #{endVal}"
        newVal = (startVal + endVal)/2 #rounds down, so this number is always the end of the front range
        if c == 'F'
            #take front half
            endVal = newVal
        elsif c == 'B'
            #take back half
            startVal = newVal+1 #end of the first range + 1 is the start of the back range
        end
    end
    rowNum = startVal
    #puts "startVal is #{startVal} and endVal is #{endVal} and rownum is #{rowNum}"

    #now calculate the column number
    startVal=0
    endVal = 7
    values[7,3].each_char do |c|
        #puts "#{startVal}, #{endVal}"
        newVal = (startVal + endVal)/2 #rounds down, so this number is always the end of the front range
        if c == 'L'
            #take front half
            endVal = newVal
        elsif c == 'R'
            #take back half
            startVal = newVal + 1 #end of the first range + 1 is the start of the back range
        end
    end
    columnNum = startVal
    #puts "startVal is #{startVal} and endVal is #{endVal} and columnNum is #{columnNum}"

    

    return (rowNum * 8) + columnNum
end

highestID = 0

inputArray.each do |boardingpass|
    curSeatID = calculateSeatID(boardingpass)
    puts curSeatID
    if curSeatID > highestID
        highestID = curSeatID
    end
end

puts "Highest SeatID is #{highestID}"