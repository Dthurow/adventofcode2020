#!/usr/bin/env ruby
#puzzle: input is a series of "passports". Each passport is represented as a sequence 
#of key:value pairs separated by spaces or newlines. Passports are separated by blank lines.
#Valid passports must have all given fields, cid is optional. They also must be validated
#Given Fields and validation reqs:
# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
# If cm, the number must be at least 150 and at most 193.
# If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.
#solution: the number of valid passports in the input

inputFile = File.open("day4_input.txt")

inputArray = inputFile.readlines


#codify the requirements for each key value pair that must exist
#and the requirements for it to be valid
class Requirement
    def initialize(keyname, validationfunction)
       @keyname = keyname
       @isValid = validationfunction
     end
     
     def keyname
        @keyname
     end

     def isValid (value)
        return @isValid.call(value)
     end
end

requirements = [
    Requirement.new(
        "byr", 
        lambda { |val| 
            return (val.to_i >= 1920 and val.to_i <= 2002)
        }
    ),
    Requirement.new(
        "iyr", 
        lambda { |val| 
            return (val.to_i >= 2010 and val.to_i <= 2020)
        }
    ),
    Requirement.new(
        "eyr", 
        lambda { |val| 
            return (val.to_i >= 2020 and val.to_i <= 2030)
        }
    ),
    Requirement.new(
        "hgt", 
        lambda { |val| 
            # ^ match must start at beginning of line
            #[0-9]? one or more numbers in a row
            #$ end of the string (prevents valid match followed by other stuff on the line)
            if val.match(/^[0-9]+cm$/)
                number=val.tr("cm", "").to_i
                return (number >= 150 and number <= 193)
            elsif val.match(/^[0-9]+in$/)
                number=val.tr("in", "").to_i
                return (number >= 59 and number <= 76)
            else
                return false
            end
            
        }
    ),
    Requirement.new(
        "hcl", 
        lambda { |val| 
            return (val.match(/^#[0-9a-f]{6}$/))
        }
    ),
    Requirement.new(
        "ecl", 
        lambda { |val| 
            return (["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include? val)
        }
    ),
    Requirement.new(
        "pid", 
        lambda { |val| 
            return (val.match(/^[0-9]{9}$/))
        }
    ),

]

validpasswordcount = 0


#transform input into an array of hashes 
#(each array item a passport, with the hashes having the kvp for that passport)

passportArray = []
curPassport= Hash.new

inputArray.each do |line|
    line = line.chomp
    if line == ""
        #end of the given passport data
        #future lines are for a new passport
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
    requirements.each do |req|
        if passport.has_key?(req.keyname)
           #check validity
           unless req.isValid(passport[req.keyname])
            puts "passport #{passport} has invalid #{req.keyname} with value of #{passport[req.keyname]}"
            isValid = false
            break
           end
        else
            puts "passport #{passport} is missing #{req.keyname}"
            isValid = false
            break
        end
    end

    if isValid
        validpasswordcount += 1
    end

end

puts "Total valid passwords: #{validpasswordcount}"

