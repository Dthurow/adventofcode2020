#!/usr/bin/env ruby
#puzzle: input is a grid of seats (empty seats L, full seats are #) and floor (represented by . )
# Essentially it's a game of life rip off.Each time step has a set of pre-defined rules that change
# seats to either empty or full. "Adjacent" seats are the first seat in each of the 8 directions (up/down/left/right/upper left/upper right/lower left/lower right)
# Rules:
# If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
# If a seat is occupied (#) and five or more seats adjacent to it are also occupied, the seat becomes empty.
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
                    elsif chair == "#" and neighbors >= 5
                        # If a seat is occupied (#) and five or more seats adjacent to it are also occupied, the seat becomes empty.
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
        #count left
        if j > 0
            
            index = j-1
            while index > 0 and @floorMap[i][index] == "."
                index -= 1
            end
            neighbors += (@floorMap[i][index] == "#" ? 1 : 0)
        end

        #count right
        if j < @floorMap[i].length-1
            
            index = j+1
            while index < @floorMap[i].length-1 and @floorMap[i][index] == "."
                index += 1
            end
            neighbors += (@floorMap[i][index] == "#" ? 1 : 0)
        end

        #count up
        if i > 0
            
            index = i-1
            while index > 0 and @floorMap[index][j] == "."
                index -= 1
            end
            neighbors += (@floorMap[index][j] == "#" ? 1 : 0)
        end

        #count down
        if i < @floorMap.length-1
            
            index = i+1
            while index < @floorMap.length-1 and @floorMap[index][j] == "."
                index += 1
            end
            neighbors += (@floorMap[index][j] == "#" ? 1 : 0)
        end

        #count upper left
        if i > 0 and j > 0
            
            indexI = i-1
            indexJ = j-1
            while indexI > 0 and indexJ > 0 and @floorMap[indexI][indexJ] == "."
                indexI -= 1
                indexJ -= 1
            end
            neighbors += (@floorMap[indexI][indexJ] == "#" ? 1 : 0)

        end

        #count upper right
        if i > 0 and j < @floorMap[i].length-1
            
            indexI = i-1
            indexJ = j+1
            while indexI > 0 and indexJ < @floorMap[i].length-1 and @floorMap[indexI][indexJ] == "."
                indexI -= 1
                indexJ += 1
            end
            
            neighbors += (@floorMap[indexI][indexJ] == "#" ? 1 : 0)

        end

        #count lower left
        if i < @floorMap.length-1 and j > 0
            
            indexI = i+1
            indexJ = j-1
            while indexI < @floorMap.length-1 and indexJ > 0 and @floorMap[indexI][indexJ] == "."
                indexI += 1
                indexJ -= 1
            end
            
            neighbors += (@floorMap[indexI][indexJ] == "#" ? 1 : 0)

        end


        #count lower right
        if i < @floorMap.length-1 and j < @floorMap[i].length-1
            
            indexI = i+1
            indexJ = j+1
            while indexI < @floorMap.length-1 and indexJ < @floorMap[i].length-1 and @floorMap[indexI][indexJ] == "."
                indexI += 1
                indexJ += 1
            end
            
            neighbors += (@floorMap[indexI][indexJ] == "#" ? 1 : 0)

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

def main
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
end

main