#!/usr/bin/env ruby
#puzzle: input is a series of commands to move a ship around. 
#the input consists of a sequence of single-character actions paired with integer input values.
# they mean:
#    Action N means to move north by the given value.
#    Action S means to move south by the given value.
#    Action E means to move east by the given value.
#    Action W means to move west by the given value.
#    Action L means to turn left the given number of degrees.
#    Action R means to turn right the given number of degrees.
#    Action F means to move forward by the given value in the direction the ship is currently facing.

#solution:
# Follow input instructions, then find the manhatten distance 
# (sum of the absolute values of its east/west position and its north/south position)
# with the ships starting position as 0,0 and facing east

# east is positive, west is negative
# north is positive, south is negative
class ShipState

    def initialize
        @EastWest = 0
        @NorthSouth = 0
        @Facing = "E"
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
        when 'F'
            Move(@Facing, amount) #move in the direction ship is facing
        else
            raise 'Invalid direction'
        end
    end

    def ChangeDirection(whichWay, degrees)
        raise unless (whichWay == 'L' or whichWay == 'R') and degrees.is_a?(Integer)
        directionOrder = ['W', 'N', 'E', 'S']
        currentIndex = directionOrder.index @Facing
        numberOfTimesToTurn =  degrees/90

        if whichWay == 'R'
            currentIndex = (currentIndex + numberOfTimesToTurn) % directionOrder.length
        else
            currentIndex = currentIndex - numberOfTimesToTurn
        end

        @Facing = directionOrder[currentIndex]

    end


    def EastWest
        @EastWest
    end
    def NorthSouth
        @NorthSouth
    end

    def Facing
        @Facing
    end

    def displayStatus
        puts "Currently: #{@EastWest}, #{@NorthSouth}, facing #{@Facing}"
    end


end


def main
    myShip = ShipState.new

    inputFile = File.open("day12_input.txt")

    inputArray = inputFile.readlines

    #apply all rules
    inputArray.each do |step| 
        puts "applying next step"
        if step[0].match(/^[LR]/)
            myShip.ChangeDirection(step[0], step[1, step.length].to_i)
        else
            myShip.Move(step[0], step[1, step.length].to_i)
        end
        myShip.displayStatus

    end
    puts "final status"
    myShip.displayStatus
    puts "manhatten distance is #{myShip.EastWest.abs + myShip.NorthSouth.abs}"
    
end
main