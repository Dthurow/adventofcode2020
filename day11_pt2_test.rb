require_relative "day11_pt2"
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
        assert_equal(6, myInstance.countOccupiedSeatNeighborsOf(1,8))
    end

    def test_countOccupiedSeatNeighborsOf_with_some_occupied
        #arrange
        floorMapArray = [
            ".##.##.",
            "#.#.#.#",
            "##...##",
            "...L...",
            "##...##",
            "#.#.#.#",
            ".##.##."
        ]


        myInstance = DayEleven.new floorMapArray

        #act and assert
        assert_equal(0, myInstance.countOccupiedSeatNeighborsOf(3,3))


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
            "#.LL.LL.L#",
            "#LLLLLL.LL",
            "L.L.L..L..",
            "LLLL.LL.LL",
            "L.LL.LL.LL",
            "L.LLLLL.LL",
            "..L.L.....",
            "LLLLLLLLL#",
            "#.LLLLLL.L",
            "#.LLLLL.L#"
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