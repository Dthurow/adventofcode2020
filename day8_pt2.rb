#!/usr/bin/env ruby
#puzzle: input is some psuedo-assembly with an infinite loop in it

# The boot code is represented as a text file with one instruction per line of text. 
#Each instruction consists of an operation (acc, jmp, or nop) and an argument (a signed number like +4 or -20).
#instructions:
# acc increases or decreases a single global value called the accumulator by the value given in the argument. For example, acc +7 would increase the accumulator by 7. The accumulator starts at 0. After an acc instruction, the instruction immediately below it is executed next.
# jmp jumps to a new instruction relative to itself. The next instruction to execute is found using the argument as an offset from the jmp instruction; for example, jmp +2 would skip the next instruction, jmp +1 would continue to the instruction immediately below it, and jmp -20 would cause the instruction 20 lines above to be executed next.
# nop stands for No OPeration - it does nothing. The instruction immediately below it is executed next.

#solution: by changing one nop to jmp or one jmp to nop, 
#prevent this from infinite looping and give the value of the accumulator after the program terminates

#read the input
inputFile = File.open("day8_input.txt")

$inputArray = inputFile.readlines



#process instructions until hit first nop/jmp decision point
# create a save point with the current accumulator and processed lines
# try to do a opposite of the given nop/jmp 
# if finishes program, found problem nop/jmp change!
# if it infinite loops, go back to saved node and try to do the given nop/jmp
# run until it hits the next nop/jmp decision point
# create save point
# etc. etc.

#setup psuedo-computer
$pcRegister = 0
$accumulator = 0
$processedLines = []

#save state
$savedpcRegister = 0
$savedAccumulator = 0
$savedProcessedLines = []


#process instructions
def processInstruction(instruction)
    $processedLines << $pcRegister

    case instruction.split(' ')[0]
    when "acc"
        puts "accumulating by #{instruction.split(' ')[1]}"
        $accumulator += instruction.split(' ')[1].to_i
        $pcRegister += 1
    when "nop"
        puts "nopin out"
        $pcRegister += 1
    when "jmp"
        puts "jumping by #{instruction.split(' ')[1].to_i}"
        $pcRegister += instruction.split(' ')[1].to_i
    end

end

def processOnlyAccs()
    while $inputArray[$pcRegister].split(' ')[0] == "acc"
        $processedLines << $pcRegister
        $accumulator +=  $inputArray[$pcRegister].split(' ')[1].to_i
        $pcRegister += 1
    end
end


while not $processedLines.include? $pcRegister

    #process instructions until we get to jmp/nop
    processOnlyAccs
    
    #save point before making a decision!
    $savedAccumulator = $accumulator
    $savedpcRegister = $pcRegister
    #need a deep copy of this array, not just reference to it so updates to processedLines doesn't affect save point
    $savedProcessedLines = $processedLines[0 .. $processedLines.length]
    puts "save point is: #{$savedAccumulator}, #{$savedpcRegister}, #{$savedProcessedLines}"

    #make try doing the opposite of what it says
    #if next instruction is a nop, do jump, or vice versa
    puts "trying new instruction"
    if $inputArray[$pcRegister].split(' ')[0] == "jmp"
        newInstruction = "nop #{$inputArray[$pcRegister].split(' ')[1]}"
        processInstruction(newInstruction)
    else
        newInstruction = "jmp #{$inputArray[$pcRegister].split(' ')[1]}"
        processInstruction(newInstruction)
    end

    #run the program normally until it loops or successfully finish the program
    while not $processedLines.include? $pcRegister
        if $pcRegister >= $inputArray.length
            #reached end of the program!
            puts "Success! final accumulator value is #{$accumulator}"
            return
        end
        #process instructions
        processInstruction($inputArray[$pcRegister])
    end

    #getting to here means there was an infinte loop. reload save point, try different option
    puts "Infinite loop found, reseting and trying again"
    puts "old values: #{$accumulator}, #{$pcRegister}, #{$processedLines}"
    puts "new values: #{$savedAccumulator}, #{$savedpcRegister}, #{$savedProcessedLines}"
    $accumulator = $savedAccumulator
    $pcRegister = $savedpcRegister
    $processedLines = $savedProcessedLines[0 .. $savedProcessedLines.length]

    #do the given value then loop back around
    processInstruction($inputArray[$pcRegister])
end

