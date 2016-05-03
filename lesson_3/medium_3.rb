# Exercises: Medium 3

def prompt(message)
  puts "> #{message}"
end

def question_1
  prompt 'QUESTION 1'
  puts 'Ruby will use the same object when it can.'
  puts 'Nothing has changed in the block.'
  puts 'All ids are updated when the variables have been reassigned to different objects.'
  puts 'Ruby trys to reuse some objects when it can.'
  puts 'Variables declared in the block cannot be accessed outside of the block.'
end

def question_2
  prompt 'QUESTION 2'
  puts 'Ruby will use the same object when it can.'
  puts 'In the method, the object that are passed into are the same as outside of the method. The variables are not the same.'
  puts 'The objects changed when they are reassigned.'
  puts 'Ruby will try to reuse the objects when it can.'
  puts 'Ruby does not have access to the variables declared within the method.'
end

def question_3
  prompt 'QUESTION 3'
  puts 'My string looks like this now: pumpkins'
  puts 'My array looks like this now: ["pumpkins", "rutabaga"]'
  puts 'The string was unchanged, the variable a_string_param points to something else in the tricky_method.'
  puts 'The arary was changed because << updated the object itself.'
end

def question_4
  prompt 'QUESTION 4'
  puts 'My string looks like this now: rutabaga'
  puts 'My array looks like this now: ["pumpkins"]'
end

def question_5
  prompt 'QUESTION 5'
  # color == "blue" || color == "green"
end
