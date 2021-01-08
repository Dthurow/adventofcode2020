#!/usr/bin/env ruby
#puzzle: input is a series of commands to move a ship around. 
#the input consists of a sequence of single-character actions paired with integer input values.
# they mean:

# Action N means to move the waypoint north by the given value.
# Action S means to move the waypoint south by the given value.
# Action E means to move the waypoint east by the given value.
# Action W means to move the waypoint west by the given value.
# Action L means to rotate the waypoint around the ship left (counter-clockwise) the given number of degrees.
# Action R means to rotate the waypoint around the ship right (clockwise) the given number of degrees.
# Action F means to move forward to the waypoint a number of times equal to the given value.

#solution:
# Follow input instructions, then find the manhatten distance 
# (sum of the absolute values of its east/west position and its north/south position)
# with the ships starting position as 0,0 and facing east

# east is positive, west is negative
# north is positive, south is negative

class WaypointState

    #The waypoint starts 10 units east and 1 unit north
    def initialize
        @EastWest = 10
        @NorthSouth = 1
    end

    def Move(direction, amount)
        case direction
        when 'N'
            @NorthSouth += amount
        when 'S'
            @NorthSouth -= amount
        when 'E'
            @EastWest += amount
        when 'W'
            @EastWest -= amount
        else
            raise 'Invalid direction'
        end
    end

    def ChangeDirection(whichWay, degrees)
        raise unless (whichWay == 'L' or whichWay == 'R') and degrees.is_a?(Integer)

        numberOfTimesToTurn = degrees/90

        #rotate the waypoint around the ship
        if whichWay == 'R'
            for x in 1..numberOfTimesToTurn
                oldVal = @EastWest
                @EastWest = @NorthSouth
                @NorthSouth = -oldVal
            end
        else
            for x in 1..numberOfTimesToTurn
                oldVal = @EastWest
                @EastWest = -@NorthSouth
                @NorthSouth = oldVal

            end
          
        end

    end

    def EastWest
        @EastWest
    end
    def NorthSouth
        @NorthSouth
    end
end

class ShipState

    def initialize
        @EastWest = 0
        @NorthSouth = 0
        @Waypoint = WaypointState.new
    end

    def Move(direction, amount)
        if direction == 'F'
           #move towards the waypoint the number of times given in amount
            @EastWest = @EastWest + (@Waypoint.EastWest * amount)
            @NorthSouth = @NorthSouth + (@Waypoint.NorthSouth * amount)

        else
            #move the waypoint
            @Waypoint.Move direction, amount
        end
    end


    def EastWest
        @EastWest
    end
    def NorthSouth
        @NorthSouth
    end

    def Waypoint
        @Waypoint
    end

    def displayStatus
        puts "Currently: #{@EastWest}, #{@NorthSouth}"
        puts "Waypoint is #{@Waypoint.EastWest}, #{@Waypoint.NorthSouth} from ship"
    end


end


def main
    myShip = ShipState.new

    inputFile = File.open("day12_input.txt")

    inputArray = inputFile.readlines

    #apply all rules
    inputArray.each do |step| 
        if step[0].match(/^[LR]/)
            myShip.Waypoint.ChangeDirection(step[0], step[1, step.length].to_i)
        else
            myShip.Move(step[0], step[1, step.length].to_i)
        end

    end
    puts "final status"
    myShip.displayStatus
    puts "manhatten distance is #{myShip.EastWest.abs + myShip.NorthSouth.abs}"
    
end
main