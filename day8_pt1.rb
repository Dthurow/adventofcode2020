#!/usr/bin/env ruby
#puzzle: input is some psuedo-assembly with an infinite loop in it

# The boot code is represented as a text file with one instruction per line of text. 
#Each instruction consists of an operation (acc, jmp, or nop) and an argument (a signed number like +4 or -20).
#instructions:
# acc increases or decreases a single global value called the accumulator by the value given in the argument. For example, acc +7 would increase the accumulator by 7. The accumulator starts at 0. After an acc instruction, the instruction immediately below it is executed next.
# jmp jumps to a new instruction relative to itself. The next instruction to execute is found using the argument as an offset from the jmp instruction; for example, jmp +2 would skip the next instruction, jmp +1 would continue to the instruction immediately below it, and jmp -20 would cause the instruction 20 lines above to be executed next.
# nop stands for No OPeration - it does nothing. The instruction immediately below it is executed next.

#solution: what is the value of the global accumulator value before code loops a second time?

#read the input
inputFile = File.open("day8_input.txt")

inputArray = inputFile.readlines

#setup psuedo-computer
$pcRegister = 0
$accumulator = 0
processedLines = []

def processInstruction(instruction)

    case instruction.split(' ')[0]
    when "acc"
        puts "accumulating by #{instruction.split(' ')[1]}"
        $accumulator += instruction.split(' ')[1].to_i
        $pcRegister += 1
    when "nop"
        puts "nopin out"
        $pcRegister += 1
    when "jmp"
        puts "jumping to #{instruction.split(' ')[1].to_i}"
        $pcRegister += instruction.split(' ')[1].to_i
    end

end

while not processedLines.include? $pcRegister
    #process instructions
    processedLines << $pcRegister
    processInstruction(inputArray[$pcRegister])
end

print "Accumulator final val is #{$accumulator}"