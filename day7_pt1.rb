#!/usr/bin/env ruby
#puzzle: input is a series of rules of which bags can contain other bags
# each bag type is described as [adjective] [color]  bag (e.g. shiny gold bag)
#solution: find the number of bags that can eventually contain a shiny gold bag


#read the input
inputFile = File.open("day7_input.txt")

inputArray = inputFile.readlines

#store rules in a hash, where the key is the bag name (not including the word "bag")
# and the value is an array of bags that can contain the key
BagRules = Hash.new

inputArray.each do |line|
    line = line.chomp
    line.split("contain")
    
    containingBag = line.split("contain")[0]
    containingBag.slice! " bags " #remove trailing "bags"

    #get array of bags that can be inside the given bag
    containedBags = line.split("contain")[1].split(",")
    
    containedBags.each do |bag|
        bag = bag[3, bag.length] # remove leading " [0-9] ", and remove the last " bag" part of string
        bag.slice! " bags."
        bag.slice! " bag."
        bag.slice! " bags"
        bag.slice! " bag"

        unless BagRules.has_key? bag
            BagRules[bag] = []
        end    
        BagRules[bag] << containingBag
    end

end
puts "total keys #{BagRules.keys}"


workingQ = ["shiny gold"]
processedArray = []

while workingQ.length > 0
    #pop the first bag
    bag = workingQ.pop
    
    if BagRules.has_key? bag
        
        newBags = BagRules[bag]
        puts "#{bag} can be contained in #{newBags}"

        #remove already processed bags, so we dont get dupes
        newBags = newBags - (newBags & processedArray) - (newBags & workingQ) 
        workingQ = newBags + workingQ
    end

    processedArray << bag #finished processing that bag so add it to the processedArray
    puts "current workingQ is #{workingQ}"

end


puts "total processed #{processedArray}"
puts "final count #{processedArray.length-1}"

