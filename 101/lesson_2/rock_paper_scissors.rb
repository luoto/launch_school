VALID_CHOICES = %w(rock paper scissors).freeze

def prompt(message)
  puts "> #{message}"
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
end

def display_results(player, computer)
  if win? player, computer
    prompt 'You won!'
  elsif win? computer, player
    prompt 'Computer won!'
  else
    prompt 'It\'s a tie!'
  end
end

loop do
  player = nil
  computer = VALID_CHOICES.sample

  prompt "Choose one: #{VALID_CHOICES.join(', ')}"
  player = gets.chomp

  loop do
    break if VALID_CHOICES.include? player
    prompt 'That was not a valid choice...'
  end

  prompt "You chose: #{player}; Computer chose: #{computer}"
  display_results(player, computer)

  prompt 'Play again? ([n]y)'
  again = gets.chomp
  break unless again.downcase.start_with?('y')
end

prompt 'Thank you for playing RPSLS!'
