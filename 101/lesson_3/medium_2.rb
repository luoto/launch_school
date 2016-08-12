# Exercises: Medium 2

def prompt(message)
  puts "> #{message}"
end

def question_1
  prompt 'QUESTION 1'
  munsters = {
    "Herman" => { "age" => 32, "gender" => "male" },
    "Lily" => { "age" => 30, "gender" => "female" },
    "Grandpa" => { "age" => 402, "gender" => "male" },
    "Eddie" => { "age" => 10, "gender" => "male" }
  }
  total_age = 0
  munsters.each do |name, details|
    total_age += details['age'] if details['gender'] == 'male'
  end
end

def question_2
  prompt 'QUESTION 2'
  munsters = {
    "Herman" => { "age" => 32, "gender" => "male" },
    "Lily" => { "age" => 30, "gender" => "female" },
    "Grandpa" => { "age" => 402, "gender" => "male" },
    "Eddie" => { "age" => 10, "gender" => "male" },
    "Marilyn" => { "age" => 23, "gender" => "female"}
  }
  munsters.each do |name, details|
    puts "#{name} is a #{details['age']} year old #{details['gender']}"
  end
end

def question_3
  prompt 'QUESTION 3'
  puts 'We can split into two different methods one that takes a string parameter, and another that takes the array parameter. We can also use the bang to signify that the original array will be modified. Or, we can make the method not modify the arguments and explicitly return values.'
end

def question_4
  prompt 'QUESTION 4'
  sentence = "Humpty Dumpty sat on a wall."
  p sentence.split(/\W/).reverse.join(' ') + '.'
end

def question_5
  prompt 'QUESTION 5'
  puts '34'
end

def question_6
  prompt 'QUESTION 6'
  puts 'The family\'s data was ransacked because hashes are passed by reference and the demo_hash was always pointing at the munsters hash.'
end

def question_7
  prompt 'QUESTION 7'
  puts 'paper'
end

def question_8
  prompt 'QUESTION 8'
  puts 'no'
end
