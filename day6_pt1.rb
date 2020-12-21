#!/usr/bin/env ruby
#puzzle: input is a series of "yes" answers to a quiz. one line per person, empty new lines indicate a new
#group of people. Each letter represents a specific question that a person answered yes to.
#calculate the number of questions each group collectively answered yes to (i.e. dupes dont matter, union of all the groups answers)
#solution: For each group, count the number of questions to which anyone answered "yes". What is the sum of those counts?


#read the input
inputFile = File.open("day6_input.txt")

inputArray = inputFile.readlines

#for each group, concatenate all answers into a single line

groupAnswerArray = []
totalCount = 0

inputArray.each do |line|
    line = line.chomp
    if line == ''
        #new group! display results and get ready for new group
        puts "Group answered #{groupAnswerArray.sort}"
        totalCount = totalCount + groupAnswerArray.length
        groupAnswerArray = []
    else
        #add to existing group answer
        #union so no dupes exist
        puts "Old array was #{groupAnswerArray}"
        groupAnswerArray = groupAnswerArray | line.chars
        puts "new array with #{line} is #{groupAnswerArray}"
    end
end

puts "Final group answered #{groupAnswerArray.sort}"
totalCount = totalCount + groupAnswerArray.length

puts "Total count is #{totalCount}"