#!/usr/bin/env ruby
#puzzle: input is a series of rules of which bags can contain other bags
# each bag type is described as [adjective] [color]  bag (e.g. shiny gold bag)
#solution: find the number of bags are contained inside a shiny gold bag


#read the input
inputFile = File.open("day7_input.txt")

inputArray = inputFile.readlines

#store rules in a hash, where the key is the bag name (not including the word "bag")
# and the value is an array of bags that the key must hold, including the number of each bag needed
BagRules = Hash.new

class BagReq
    def initialize(number, bagName)
       @number = number
       @bagName = bagName
     end
     
     def number
        @number
     end
     def bagName
        @bagName
     end

     
end


inputArray.each do |line|
    line = line.chomp
    line.split("contain")
    
    containingBag = line.split("contain")[0]
    containingBag.slice! " bags " #remove trailing "bags"

    #get array of bags that can be inside the given bag
    containedBags = line.split("contain")[1].split(",")
    
    containedBags.each do |bag|
        bagCount = bag[1,1].to_i # the number is after a space, e.g. " 1 "
        
        bag = bag[3, bag.length] # remove leading " [0-9] ", and remove the last " bag" part of string
        bag.slice! " bags."
        bag.slice! " bag."
        bag.slice! " bags"
        bag.slice! " bag"

        unless BagRules.has_key? containingBag
            BagRules[containingBag] = []
        end    

        BagRules[containingBag] << BagReq.new(bagCount, bag)
    end

end

#using recursion, baby!
def getTotalBagCount(bagName)

    if BagRules.has_key? bagName
        totalBagCount = 0
        newBags = BagRules[bagName]
        puts "#{bagName} needs to contain #{newBags}"

        newBags.each do |newBag|

            # so bagName will need to include the number of bags specified by newBags.number
            # as well as the number of bags inside newBag.
            #example: newbag.number=2, newbag.bagName = "dark purple"
            # total bag count is 2 dark purple bags, plus how many bags are in one dark purple bag, multiplied by 2
            totalBagCount = totalBagCount + newBag.number + (newBag.number * getTotalBagCount(newBag.bagName))

        end

        return totalBagCount
    else
        #no bags are required inside this one
        return 0
    end

end


puts "total number of bags needed is #{getTotalBagCount('shiny gold')}"

