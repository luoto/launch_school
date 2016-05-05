require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]].freeze # diagonals

INITIAL_MARKER = ' '.freeze
PLAYER_MAKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze

def prompt(message)
  puts "> #{message}"
end

def joinor(array, delimiter=', ', conjunction='or')
  new_array = array.slice(0..-2)
  new_array.join(delimiter) + "#{delimiter}#{conjunction} #{array.last}"
end

# rubocop:disable Metrics/AbcSize
def display_board(board)
  system 'clear'
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
  # binding.pry
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

def computer_places_piece!(board)
  square = empty_squares(board).sample
  board[square] = COMPUTER_MARKER
end

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

loop do
  board = initialize_board

  loop do
    display_board board

    player_places_piece! board
    break if (someone_won? board) || (board_full? board)

    computer_places_piece! board
    break if (someone_won? board) || (board_full? board)
  end

  display_board board

  if someone_won? board
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end
  prompt "Play again? [Y/n]"
  answer = gets.chomp
  break if answer.downcase.start_with? 'n'
end

prompt 'Thanks for playing Tic Tac Toe! Good bye!'
