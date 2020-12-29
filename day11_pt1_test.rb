require_relative "day11_pt1"
require "test/unit"

class TestDayEleven < Test::Unit::TestCase
 
    def test_count_with_zero_occupied
        #Arrange
        myInstance = DayEleven.new "day11_testinput.txt"

        #act
        val = myInstance.countOccupiedSeats
        #assert
        assert_equal(0, val)

    end

    def test_count_with_occupied_seats
        #arrange
        floorMapArray = [
            "#.#L.L#.##",
            "#LLL#LL.L#",
            "L.#.L..#..",
            "#L##.##.L#",
            "#.#L.LL.LL",
            "#.#L#L#.##",
            "..L.L.....",
            "#L#L##L#L#",
            "#.LLLLLL.L",
            "#.#L#L#.##"
        ]


        myInstance = DayEleven.new floorMapArray

        #act
        val = myInstance.countOccupiedSeats
        #assert
        assert_equal(37, val)


    end

    def test_countOccupiedSeatNeighborsOf_with_all_occupied
        #arrange
        floorMapArray = [
            "#.##.##.##",
            "#######.##",
            "#.#.#..#..",
            "####.##.##",
            "#.##.##.##",
            "#.#####.##",
            "..#.#.....",
            "##########",
            "#.######.#",
            "#.#####.##"
        ]


        myInstance = DayEleven.new floorMapArray

        #act and assert
        assert_equal(4, myInstance.countOccupiedSeatNeighborsOf(1,8))
    end

    def test_countOccupiedSeatNeighborsOf_with_some_occupied
        #arrange
        floorMapArray = [
            "#.#L.L#.##",
            "#LLL#LL.L#",
            "L.#.L..#..",
            "#L##.##.L#",
            "#.#L.LL.LL",
            "#.#L#L#.##",
            "..L.L.....",
            "#L#L##L#L#",
            "#.LLLLLL.L",
            "#.#L#L#.##"
        ]


        myInstance = DayEleven.new floorMapArray

        #act and assert
        assert_equal(1, myInstance.countOccupiedSeatNeighborsOf(0,0))
        assert_equal(2, myInstance.countOccupiedSeatNeighborsOf(0,9))
        assert_equal(1, myInstance.countOccupiedSeatNeighborsOf(9,9))
        assert_equal(3, myInstance.countOccupiedSeatNeighborsOf(3,3))


    end

   
    def test_applyNextStep_from_test_input
        #arrange
        myInstance = DayEleven.new "day11_testinput.txt"
        finalFloorMap = [
            "#.##.##.##",
            "#######.##",
            "#.#.#..#..",
            "####.##.##",
            "#.##.##.##",
            "#.#####.##",
            "..#.#.....",
            "##########",
            "#.######.#",
            "#.#####.##"
        ]
        finalFloorMap.map! do |val|
            val.chomp!
            val.split("")
        end

        #act
        change = myInstance.applyNextStep

        #assert
        assert(change)
        assert_equal(myInstance.FloorMap, finalFloorMap)
    end

    def test_applyNextStep_from_later_on
        #arrange
        startFloorMap = [
            "#.##.##.##",
            "#######.##",
            "#.#.#..#..",
            "####.##.##",
            "#.##.##.##",
            "#.#####.##",
            "..#.#.....",
            "##########",
            "#.######.#",
            "#.#####.##"
        ]

        finalFloorMap = [
            "#.LL.L#.##",
            "#LLLLLL.L#",
            "L.L.L..L..",
            "#LLL.LL.L#",
            "#.LL.LL.LL",
            "#.LLLL#.##",
            "..L.L.....",
            "#LLLLLLLL#",
            "#.LLLLLL.L",
            "#.#LLLL.##"
        ]

        finalFloorMap.map! do |val|
            val.chomp!
            val.split("")
        end

        myInstance = DayEleven.new startFloorMap

        #act
        change = myInstance.applyNextStep

        #assert
        assert(change)
        assert_equal(finalFloorMap, myInstance.FloorMap)

    end

  end