# frozen_string_literal: true

class RomanNumeralDefinitions
  RomanToArabic = {
    I: 1,
    V: 5,
    X: 10,
    L: 50,
    C: 100,
    D: 500,
    M: 1000
  }.freeze

  AlwaysAdded = {
      M: true,
      D: true,
      L: true,
      V: true
  }
end

def fromRoman(romanNumber)
  # Replace the following line with the actual code!
  arabicTotal = 0
  previousLetter = nil
  romanNumber.each_char do |letter|
    raise TypeError if RomanNumeralDefinitions::RomanToArabic[:"#{letter}"].nil?

    unless previousLetter.nil?
      arabicTotal += if RomanNumeralDefinitions::AlwaysAdded[:"#{previousLetter}"].nil?
                       getPreviousLetterValue(letter, previousLetter)
                     else
                       RomanNumeralDefinitions::RomanToArabic[:"#{previousLetter}"]
                     end
    end
    previousLetter = letter
  end
  arabicTotal + RomanNumeralDefinitions::RomanToArabic[:"#{previousLetter}"]
end

def getPreviousLetterValue(letter, previousLetter)
  previousLetterValue = RomanNumeralDefinitions::RomanToArabic[:"#{previousLetter}"]
  letterValue = RomanNumeralDefinitions::RomanToArabic[:"#{letter}"]
  previousLetterValue >= letterValue ? previousLetterValue : -previousLetterValue
end

def toRoman(arabicNumber)
  # Replace the following line with the actual code!
  raise RangeError if (arabicNumber <= 0) || (arabicNumber >= 4000)

  romanNumber = getNumeralsAtLowerRomanPlaceholder('M', '', '', arabicNumber)
  romanNumber += getNumeralsAtLowerRomanPlaceholder('C', 'D', 'M', arabicNumber)
  romanNumber += getNumeralsAtLowerRomanPlaceholder('X', 'L', 'C', arabicNumber)
  romanNumber + getNumeralsAtLowerRomanPlaceholder('I', 'V', 'X', arabicNumber)
end

def getNumeralsAtLowerRomanPlaceholder(lowerRoman, middleRoman, highestRoman, number)
  digit = RomanNumeralDefinitions::RomanToArabic[:"#{lowerRoman}"]
  value = (number % (digit * 10)) / digit
  if value <= 3
    lowerRoman * value
  elsif value == 4
    lowerRoman + middleRoman
  elsif value == 9
    lowerRoman + highestRoman
  else
    middleRoman + (lowerRoman * (value - 5))
  end
end
