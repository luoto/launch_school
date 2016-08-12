# Exercises: Medium 1

def prompt(message)
  puts "> #{message}"
end

def question_1
  prompt 'QUESTION 1'
  statement = 'The Flintstones Rock!'
  10.times { |number| puts ' ' * number + 'The Flintstones Rock!' }
end

def question_2
  prompt 'QUESTION 2'
  statement = "The Flintstones Rock"
  frequency_hash = {}
  statement.each_char do |c|
    if frequency_hash[c] == nil
      frequency_hash[c] = 1
    else
      frequency_hash[c] += 1
    end
  end
end

def question_3
  prompt 'QUESTION 3'
  # puts "the value of 40 + 2 is " + (40 + 2) => error
  puts "the value of 40 + 2 is " + (40 + 2).to_s
  puts "the value of 40 + 2 is #{40 + 2}"
end

def question_4
  prompt 'QUESTION 4'
  puts "1. 1, 3"
  puts "2. 1, 2"
end

def question_5(number)
  prompt 'QUESTION 5'
  dividend = number
  divisors = []
  while dividend > 0 do
    divisors << number / dividend if number % dividend == 0
    dividend -= 1
  end
  divisors

  # number % dividend == - tells us that number is divisible by dividend
  # ruby inexplicitly return divisors
end

def question_6
  prompt 'QUESTION 6'
  puts 'rolling_buffer1 alters the input that is passed in, while rolling_buffer2 does not.'
end

def question_7
  prompt 'QUESTION 7'
  puts 'limit is not reachable in the method, it should be passed in to the method.'
end

def question_8
  prompt 'QUESTION 8'
  statement = "I like to eat chicken."
  p statement.split.map! { |word| word.capitalize }.join ' '
end

def question_9
  prompt 'QUESTION 9'
  munsters = {
    "Herman" => { "age" => 32, "gender" => "male" },
    "Lily" => { "age" => 30, "gender" => "female" },
    "Grandpa" => { "age" => 402, "gender" => "male" },
    "Eddie" => { "age" => 10, "gender" => "male" },
    "Marilyn" => { "age" => 23, "gender" => "female"}
  }

  munsters.each do |name, details|
    case details['age']
    when 0..18
      details['age_group'] = 'kid'
    when 18..65
      details['age_group'] = 'adult'
    else
      details['age_group'] = 'senior'
    end
  end
  p munsters
end
