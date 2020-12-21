#!/usr/bin/env ruby
#puzzle: input is a series of "passports". Each passport is represented as a sequence 
#of key:value pairs separated by spaces or newlines. Passports are separated by blank lines.
#Valid passports must have all given fields, cid is optional. Given Fields:
# byr (Birth Year)
# iyr (Issue Year)
# eyr (Expiration Year)
# hgt (Height)
# hcl (Hair Color)
# ecl (Eye Color)
# pid (Passport ID)
# cid (Country ID)
#solution: the number of valid passports in the input

inputFile = File.open("day4_input.txt")

inputArray = inputFile.readlines

reqKeys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
validpasswordcount = 0


#transform input into an array of hashes 
#(each array item a passport, with the hashes having the kvp for that passport)

passportArray = []
curPassport= Hash.new

inputArray.each do |line|
    line = line.chomp
    if line == ""
        passportArray << curPassport
        curPassport = Hash.new
    else
        kvpArray = line.split(' ')
        kvpArray.each do |kvp|
            curPassport[kvp.split(':')[0]] = kvp.split(':')[1]
        end
    end
end


#for each passport, check that a key exists (except the cid since it's optional)
#short circuit the logic if any key doesn't exist
# if it gets thru all the keys, mark it as valid
passportArray.each do |passport|
    isValid = true
    reqKeys.each do |key|
        unless passport.has_key?(key)
            puts "passport #{passport} is missing #{key}"
            isValid = false
            break
        end
    end

    if isValid
        validpasswordcount += 1
    end

end

puts "Total valid passwords: #{validpasswordcount}"

