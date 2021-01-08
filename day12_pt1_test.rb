require_relative "day12_pt1"
require "test/unit"

class TestDayTwelve < Test::Unit::TestCase
 
    def test_move
        #Arrange
        myInstance = ShipState.new

        #act
        myInstance.Move "N", 5
        myInstance.Move "S", 10
        myInstance.Move 'E', 20
        myInstance.Move 'W', 5


        #assert
        assert_equal(-5, myInstance.NorthSouth)
        assert_equal(15, myInstance.EastWest)

    end

    def test_forward_move
        #Arrange
        myInstance = ShipState.new

        #act
        myInstance.Move "N", 5
        myInstance.Move "S", 10
        myInstance.Move 'F', 20
        myInstance.Move 'W', 5


        #assert
        assert_equal(-5, myInstance.NorthSouth)
        assert_equal(15, myInstance.EastWest)
    end

    def test_change_direction
        #arrange
        myInstance = ShipState.new

        #act
        myInstance.ChangeDirection 'R', 90

        #assert
        assert_equal('S', myInstance.Facing)

        myInstance.ChangeDirection 'L', 180
        assert_equal('N', myInstance.Facing)


    end

  end