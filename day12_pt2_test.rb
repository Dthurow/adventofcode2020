require_relative "day12_pt2"
require "test/unit"

class TestDayTwelve < Test::Unit::TestCase
 
    def test_waypoint_move
         #Arrange
         myInstance = WaypointState.new

         #act
         myInstance.Move "N", 3
 
 
         #assert
         assert_equal(4, myInstance.NorthSouth)
         assert_equal(10, myInstance.EastWest)
    end

    def test_waypoint_change_direction
        #Arrange
        myInstance = WaypointState.new

        #act
        myInstance.ChangeDirection "R", 90

        #assert
        assert_equal(-10, myInstance.NorthSouth)
        assert_equal(1, myInstance.EastWest)

        #act
        myInstance.ChangeDirection "L", 180

        #assert
        assert_equal(10, myInstance.NorthSouth)
        assert_equal(-1, myInstance.EastWest)

         #act
         myInstance.ChangeDirection "L", 90

         #assert
         assert_equal(-1, myInstance.NorthSouth)
         assert_equal(-10, myInstance.EastWest)
    end


    def test_ship_move
        #arrange
        myInstance = ShipState.new
        
        #act
        myInstance.Move "F", 10

        #assert
        assert_equal(100, myInstance.EastWest)
        assert_equal(10, myInstance.NorthSouth)
        assert_equal(10, myInstance.Waypoint.EastWest)
        assert_equal(1, myInstance.Waypoint.NorthSouth)
    end
    
    #if the ship is told to move with N,W,S,E then it should move its waypoint, not itself
    def test_ship_move_waypoint
         #arrange
         myInstance = ShipState.new
        
         #act
         myInstance.Move "N", 3
 
         #assert
         assert_equal(0, myInstance.EastWest)
         assert_equal(0, myInstance.NorthSouth)
         assert_equal(10, myInstance.Waypoint.EastWest)
         assert_equal(4, myInstance.Waypoint.NorthSouth)
    end

  end