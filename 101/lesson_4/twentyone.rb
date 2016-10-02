require 'pry'

RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'].freeze
SUITS = ['Hearts', 'Spades', 'Diamonds', 'Clubs'].freeze
STARTING_CARDS = 2
MAX_POINTS = 21
DEALER_LIMIT = 17
TOURNAMENT_MAX = 5

def clear_screen
  system('clear') || system('cls')
end

def display_intro
  puts "----- Welcome to Twenty One -----"
  puts "|         First to Five         |"
  puts "---------------------------------"
end

def display_outro(dealer_hand, player_hand, winner)
  puts ""
  puts "------------Results-------------"
  puts "Winner: #{winner}"
  puts "Dealer Hand Value: #{get_hand_value(dealer_hand)}"
  puts "Player Hand Value: #{get_hand_value(player_hand)}"
  puts "---------------------------------"
end

def display_user_screen(dealer_hand, player_hand)
  prompt "Dealer has: #{dealer_hand[0][0]} and unknown card"
  prompt reveal_hand(player_hand, "Player")
end

def display_results(dealer_hand, player_hand)
  reveal_hand(dealer_hand, "Dealer")
  reveal_hand(player_hand, "Player")
  winner = determine_winner(dealer_hand, player_hand)
  display_outro(dealer_hand, player_hand, winner)
end

def display_wins(dealer, player)
  puts "*Dealer Wins: #{dealer} | Player Wins: #{player}*\n\n"
end

def prompt(msg)
  puts "> #{msg}"
end

def initialize_deck(ranks, suits)
  deck = []
  ranks.each do |rank|
    suits.each do |suit|
      deck.push([rank, suit])
    end
  end
  deck
end

def deal_card!(deck)
  random_key = rand(0..(deck.length - 1))
  deck.delete_at(random_key)
end

def initialize_hand!(hand, deck)
  STARTING_CARDS.times do |_|
    hit!(hand, deck)
  end
end

def prompt_player
  answer = nil
  loop do
    prompt('Hit or Hold?')
    answer = gets.chomp.downcase
    if answer == 'hit' || answer == 'hold'
      break
    else
      prompt('Please enter hit or hold.')
    end
  end
  answer
end

def hit!(hand, deck)
  hand.push(deal_card!(deck))
end

def reveal_hand(hand, player)
  player_string = ''
  hand.each_with_index do |card, index|
    if index == hand.size - 1
      player_string += "and #{card[0]}"
    else
      delimiter = hand.length == 2 ? " " : ", "
      player_string += "#{card[0]}#{delimiter}"
    end
  end
  prompt "#{player} has: #{player_string} [[value: #{get_hand_value(hand)}]]"
end

def get_hand_value(hand)
  ace_count = (hand.select { |card| card[0] == 'Ace' }).length
  value = 0

  hand.each do |card|
    value += if ['King', 'Queen', 'Jack'].include?(card[0])
               10
             elsif card[0] != 'Ace'
               card[0].to_i
             else
               11
             end
  end
  (1..ace_count).each do |_|
    value -= 10 if value > 21
  end
  value
end

def bust?(hand)
  get_hand_value(hand) > 21
end

def determine_winner(dealer, player)
  dealer_value = get_hand_value(dealer)
  player_value = get_hand_value(player)

  if dealer_value > 21
    "Player"
  elsif player_value > 21
    "Dealer"
  elsif dealer_value > player_value
    "Dealer"
  elsif player_value > dealer_value
    "Player"
  else
    "Tie"
  end
end

def play_again?
  prompt "Play again? (y/n)"
  loop do
    input = gets.chomp.downcase
    if input.start_with?('y')
      return true
    elsif input.start_with?('n')
      return false
    else
      prompt "Please enter yes or no."
    end
  end
end

# main game
loop do
  clear_screen
  display_intro

  dealer_wins = 0
  player_wins = 0

  loop do
    dealer_hand = []
    player_hand = []

    deck = initialize_deck RANKS, SUITS
    initialize_hand!(player_hand, deck)
    initialize_hand!(dealer_hand, deck)

    display_user_screen(dealer_hand, player_hand)

    # player's turn
    while !bust?(player_hand)
      if prompt_player == 'hit'
        prompt 'Hitting...'
        hit!(player_hand, deck)
        display_user_screen(dealer_hand, player_hand)
      else
        break
      end
    end

    if bust?(player_hand)
      display_results(dealer_hand, player_hand)
      dealer_wins += 1
      display_wins(dealer_wins, player_wins)
      break if player_wins == TOURNAMENT_MAX || dealer_wins == TOURNAMENT_MAX
      next
    end

    # dealer's turn
    while !bust?(dealer_hand) && (get_hand_value(dealer_hand) <= DEALER_LIMIT)
      prompt "(Dealer says hit me!)"
      prompt "Hitting dealer..."
      hit!(dealer_hand, deck)
      reveal_hand(dealer_hand, "Dealer")
    end

    prompt "\nRevealing hands..."

    if bust?(dealer_hand)
      display_results(dealer_hand, player_hand)
      player_wins += 1
      display_wins(dealer_wins, player_wins)
      break if player_wins == TOURNAMENT_MAX || dealer_wins == TOURNAMENT_MAX
      next
    end

    winner = determine_winner(dealer_hand, player_hand)
    if winner == "Player"
      player_wins += 1
    elsif winner == "Dealer"
      dealer_wins += 1
    end

    display_results(dealer_hand, player_hand)
    display_wins(dealer_wins, player_wins)

    break if player_wins == TOURNAMENT_MAX || dealer_wins == TOURNAMENT_MAX
  end

  if player_wins == TOURNAMENT_MAX
    prompt "PLAYER WINS THE TOURNAMENT!!!!"
  else
    prompt "DEALER WINS THE TOURNAMENT!!!!"
  end

  break unless play_again?
end
