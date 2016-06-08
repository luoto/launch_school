require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]].freeze # diagonals

INITIAL_MARKER = ' '.freeze
PLAYER_MAKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze

# Settings control for whether or not computer or player goes first
SETTINGS = 'default'.freeze

def prompt(message)
  puts "> #{message}"
end

def joinor(array, delimiter = ', ', conjunction = 'or')
  array[-1] = "#{conjunction} #{array.last}" if array.size > 1
  array.join(delimiter)
end

# rubocop:disable Metrics/AbcSize
def display_board(board)
  system 'clear' # clears console screen
  puts "You're #{PLAYER_MAKER}. Computer is #{COMPUTER_MARKER}"
  puts ""
  puts "      |       |       "
  puts "  #{board[1]}   |   #{board[2]}   |   #{board[3]}    "
  puts "      |       |       "
  puts "------+-------+-------"
  puts "      |       |       "
  puts "  #{board[4]}   |   #{board[5]}   |   #{board[6]}   "
  puts "      |       |       "
  puts "------+-------+-------"
  puts "      |       |       "
  puts "  #{board[7]}   |   #{board[8]}   |   #{board[9]}    "
  puts "      |       |       "
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def player_places_piece!(board)
  square = ''

  loop do
    prompt "Choose a square (#{joinor(empty_squares(board))}):"
    square = gets.chomp.to_i
    break if empty_squares(board).include? square
    prompt "Sorry, that's not a valid choice."
  end

  board[square] = PLAYER_MAKER
end

# rubocop:disable Style/ConditionalAssignment
def computer_places_piece!(board)
  # pick winning move
  if find_at_risk_square(board, COMPUTER_MARKER, PLAYER_MAKER)
    square = find_at_risk_square(board, COMPUTER_MARKER, PLAYER_MAKER)
  # defend
  elsif find_at_risk_square(board, PLAYER_MAKER, COMPUTER_MARKER)
    square = find_at_risk_square(board, PLAYER_MAKER, COMPUTER_MARKER)
  # pick square #5
  elsif board[5] == INITIAL_MARKER
    square = 5
  # pick random square
  else
    square = empty_squares(board).sample
  end
  board[square] = COMPUTER_MARKER
end
# rubocop:enable Style/ConditionalAssignment

def board_full?(board)
  empty_squares(board).empty?
end

def someone_won?(board)
  !!detect_winner(board)
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    return 'Player' if board.values_at(*line).count(PLAYER_MAKER) == 3
    return 'Computer' if board.values_at(*line).count(COMPUTER_MARKER) == 3
  end
  nil
end

def find_at_risk_line(board, first = PLAYER_MAKER, second = COMPUTER_MARKER)
  risk_line = []
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(first) == 2 && board.values_at(*line).count(second) == 0
      risk_line = line
      break
    end
  end
  risk_line
end

def find_at_risk_square(board, first = PLAYER_MAKER, second = COMPUTER_MARKER)
  risk_line = find_at_risk_line(board, first, second)
  return nil if risk_line.nil?
  risk_line.each do |square|
    if board[square] != first
      return square
    end
  end
  nil
end

def place_piece!(board, current_player)
  if current_player == 'player'
    player_places_piece! board
  else
    computer_places_piece! board
  end
end

def alternate_player(current_player)
  if current_player == 'player'
    'computer'
  else
    'player'
  end
end

def display_game_stats(round, player_points, computer_points, ties)
  puts "Round: #{round}"
  puts "Score: Player - #{player_points}, Computer - #{computer_points}, Ties - #{ties}"
end

loop do
  # Keeps Score
  # First player to reach 5 points wins
  player_points = 0
  computer_points = 0
  ties = 0
  round = 1
  loop do
    board = initialize_board
    # Decide who goes first if SETTINGS is set to 'choose'
    # player goes first by DEFAULT
    current_player = 'player'
    if SETTINGS == 'choose'
      loop do
        prompt "Who to go first? (player or computer)"
        first = gets.chomp
        if first.casecmp('computer') == 0 || first.casecmp('player') == 0
          current_player = first.downcase
          break
        else
          prompt "Please choose either computer or player."
        end
      end
    end

    # Start the game
    # loop will terminate if someone wins or if there is a tie
    loop do
      display_board board
      display_game_stats round, player_points, computer_points, ties
      place_piece! board, current_player
      current_player = alternate_player current_player
      break if (someone_won? board) || (board_full? board)
    end

    display_board board

    # determine results of the game
    if someone_won? board
      winner = detect_winner(board)
      prompt "#{winner} won!"
      if winner == 'Player'
        player_points += 1
      else
        computer_points += 1
      end
    else
      prompt "It's a tie!"
      ties += 1
    end
    round += 1

    # first to 5 points will end the game
    break if player_points == 5 || computer_points == 5
  end

  # display winner to console
  if player_points == 5
    prompt "Player won the series with #{player_points} points!"
  else
    prompt "Computer won the series with #{computer_points}  points!"
  end

  prompt "Play again? [Y/n]"
  answer = gets.chomp
  break if answer.downcase.start_with? 'n'
end

prompt 'Thanks for playing Tic Tac Toe! Good bye!'
