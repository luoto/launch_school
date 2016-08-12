# Exercises: Hard 1

def prompt(message)
  puts "> #{message}"
end

def question_1
  prompt 'QUESTION 1'
  puts 'greeting is nil. Greeting was initialized in the if block, but the local variable is initialized to nil.'
end

def question_2
  prompt 'QUESTION 2'
  puts '{a: \'hi there\'} because << modifies the string \'hi\''
end

def question_3
  prompt 'QUESTION 3'
  puts 'a. one is: one, two is: two, three is: three'
  puts 'b. one is: one, two is: two, three is: three'
  puts 'c. one is: two, two is: three, three is: one'
end

def question_4
  prompt 'QUESTION 4'
  hexidecimal_characters = ('0'..'9').to_a + ('a'..'f').to_a
  uuid = ''
  8.times do
    uuid += hexidecimal_characters.sample
  end
  uuid += '-'
  3.times do
    4.times do
      uuid += hexidecimal_characters.sample
    end
    uuid += '-'
  end
  12.times do
    uuid += hexidecimal_characters.sample
  end
  uuid

  # ALTERNATIVE METHOD
  # characters = [] 
  # (0..9).each { |digit| characters << digit.to_s }
  # ('a'..'f').each { |digit| characters << digit }

  # uuid = ""
  # sections = [8, 4, 4, 4, 12]
  # sections.each_with_index do |section, index|
  #   section.times { uuid += characters.sample }
  #   uuid += '-' unless index >= sections.size - 1
  # end

  # uuid

end

def question_5
  prompt 'QUESTION 5'
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.size == 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false if !is_a_number?(word)
  end
  
  return true
end

question_4
