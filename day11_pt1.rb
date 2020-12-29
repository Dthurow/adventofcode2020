#!/usr/bin/env ruby
#puzzle: input is a grid of seats (empty seats L, full seats are #) and floor (represented by . )
# Essentially it's a game of life rip off.Each time step has a set of pre-defined rules that change
# seats to either empty or full. Rules:
# If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
# If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
# Otherwise, the seat's state does not change.
#solution:
# Simulate your seating area by applying the seating rules repeatedly until no seats change state.
# find how many seats end up occupied


class DayEleven

    def initialize(input)
        raise unless input.is_a?(Array) or input.is_a?(String)
        
        inputArray = input
        if input.is_a?(String)
            #its the filename
            inputFile = File.open(input)

            inputArray = inputFile.readlines
        end

       

        @floorMap = inputArray.map do |val|
            val.chomp!
            val.split("")
        end

        
    end

    def applyNextStep()
        hasChanged = false
        newFloorMap = []
    
        #loop thru each seat
        #count neighbors
        #apply rules
        # If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
        # If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
        # Otherwise, the seat's state does not change.
        @floorMap.each_with_index do |row, i|
            newRow = row.map.with_index do |chair, j|
                if chair != "."
                    #count neighbors
                    neighbors = countOccupiedSeatNeighborsOf(i, j)
                    # If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
                    if chair == "L" and neighbors == 0
                        chair = "#"
                        hasChanged = true
                    elsif chair == "#" and neighbors > 3
                        # If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
                        chair = "L"
                        hasChanged = true
                    end
                end
                chair 
            end
            newFloorMap[i] = newRow
        end
    
        @floorMap = newFloorMap
       
        return hasChanged
    end

    def countOccupiedSeatNeighborsOf(i, j)
        neighbors = 0
        #count neighbors one row above
        if i > 0
            
            if j > 0
             neighbors += @floorMap[i-1][j-1] == "#" ? 1 : 0
            end
            neighbors += @floorMap[i-1][j] == "#" ? 1 : 0
            if j < @floorMap[i-1].length-1
                neighbors += @floorMap[i-1][j+1] == "#" ? 1 : 0
            end
        end

        # count neighbors to the left and right in the same row
        if j > 0
            neighbors += @floorMap[i][j-1] == "#" ? 1 : 0
        end
        
        if j < @floorMap[i].length-1
            neighbors += @floorMap[i][j+1] == "#" ? 1 : 0
        end
       

        #count neighbors one row below
        if i < @floorMap.length-1
            if j > 0
             neighbors += @floorMap[i+1][j-1] == "#" ? 1 : 0
            end
            neighbors += @floorMap[i+1][j] == "#" ? 1 : 0
            if j < @floorMap[i+1].length-1
                neighbors += @floorMap[i+1][j+1] == "#" ? 1 : 0
            end
        end
        

        return neighbors
    end

    def printFloorMap
        @floorMap.each do |row|
            puts row.join
        end
    end
      
    def countOccupiedSeats

        @floorMap.reduce(0) do |sum, row|
            sum + row.reduce(0) do |sum, spot|
                sum + (spot == "#" ? 1 : 0)
            end
        end
    end

    def FloorMap
        @floorMap
    end

end

myInstance = DayEleven.new "day11_input.txt"


#apply rules until it becomes static
loop do 
    puts "applying next step"
    changed = myInstance.applyNextStep
    myInstance.printFloorMap

    if not changed
        break
    end
end


puts "Final occupied count is #{myInstance.countOccupiedSeats}"