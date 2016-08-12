# Exercises: Easy 1

def prompt(message)
  puts "> #{message}"
end

def question_1
  prompt 'QUESTION 1'
  puts 'I expect the code to print out: 1 2 2 3.'
end

def question_2
  prompt 'QUESTION 2'
  puts '1. != means not equal to and it should be used when we are making a comparison.'
  puts '2. Putting ! before something like !user_name return the opposite of the boolean equivalent. For example if user_name returned true, then !user_name would return false.'
  puts '3. Putting ! after something like words.uniq! signifies that the method uniq will modify the caller.'
  puts '4. Putting ? before something does not do anything.'
  puts '5. Putting ? after something signifies that the method will return a boolean.'
  puts '6. Putting !! before something like !!user_name will return the boolean equivalent.'
end

def question_3
  prompt 'QUESTION 3'
  advice = "Few things in life are as important as house training your pet dinosaur."
  advice.gsub! 'important', 'urgent'
  p advice
end

def question_4
  prompt 'QUESTION 4'
  numbers = [1, 2, 3, 4, 5]
  numbers.delete_at 1 # deletes at index 1
  numbers.delete 1 # deletes the value 1
end

def question_5
  prompt 'QUESTION 5'
  (10..100).cover? 42
end

def question_6
  prompt 'QUESTION 6'
  famous_words = "seven years ago..."
  famous_words = "Four score and " + famous_words
  famous_words = "Four score and #{famous_words}"
end

def question_7
  prompt 'QUESTION 7'
  puts '42'
end

def question_8
  prompt 'QUESTION 8'
  flintstones = ["Fred", "Wilma"]
  flintstones << ["Barney", "Betty"]
  flintstones << ["BamBam", "Pebbles"]
  flintstones.flatten!
end

def question_9
  prompt 'QUESTION 9'
  flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
  flintstones.assoc 'Barney'
end

def question_10
  prompt 'QUESTION 10'
  flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
  flintstones_hash = {}
  flintstones.each_with_index do |name, idx|
    flintstones_hash[name] = idx
  end
  p flintstones_hash
end

question_10