# Exercises: Easy 2

def prompt(message)
  puts "> #{message}"
end

def question_1
  prompt 'QUESTION 1'
  ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
  p ages.include? 'Spot'
end

def question_2
  prompt 'QUESTION 2'
  ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
  ages.values.inject :+
end

def question_3
  prompt 'QUESTION 3'
  ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
  ages.select { |_, age| age < 100 }
end

def question_4
  prompt 'QUESTION 4'
  munsters_description = "The Munsters are creepy in a good way."
  p munsters_description.capitalize
  p munsters_description.swapcase
  p munsters_description.downcase
  p munsters_description.upcase
end

def question_5
  prompt 'QUESTION 5'
  ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
  additional_ages = { "Marilyn" => 22, "Spot" => 237 }
  ages.merge! additional_ages
end

def question_6
  prompt 'QUESTION 6'
  ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
  p ages.values.min
end

def question_7
  prompt 'QUESTION 7'
  advice = "Few things in life are as important as house training your pet dinosaur."
  advice.match 'Dino'
end

def question_8
  prompt 'QUESTION 8'
  flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
  flintstones.index {|name| name.start_with? 'Be'}
end

def question_9
  prompt 'QUESTION 9'
  flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
  flintstones.map! {|name| name[0..2]}
end

def question_10
  prompt 'QUESTION 10'
  flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
  flintstones.map! {|name| name[0..2]}
end
