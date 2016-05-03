# Exercises: Easy 3

def prompt(message)
  puts "> #{message}"
end

def question_1
  prompt 'QUESTION 1'
  #flintstones = ["Fred", "Barney", "Wilma", "Betty", "BamBam", "Pebbles"]
  flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
end

def question_2
  prompt 'QUESTION 2'
  flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
  flintstones << 'Dino'
end

def question_3
  prompt 'QUESTION 3'
  flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
  flintstones.concat %w(Dino Hoppy)
end

def question_4
  prompt 'QUESTION 4'
  advice = "Few things in life are as important as house training your pet dinosaur."
  advice.slice! 0, advice.index('house')
end

def question_5
  prompt 'QUESTION 5'
  statement = "The Flintstones Rock!"
  p statement.count 't'
end

def question_6
  prompt 'QUESTION 6'
  title = "Flintstone Family Members"
  title.center 40
end
