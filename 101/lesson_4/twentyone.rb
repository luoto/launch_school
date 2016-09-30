require 'pry'

RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'].freeze
SUITS = ['Hearts', 'Spades', 'Diamonds', 'Clubs'].freeze
STARTING_CARDS = 2
MAX_POINTS = 21
DEALER_LIMIT = 17

def clear_screen
  system('clear') || system('cls')
end

def display_intro
  puts "----- Welcome to Twenty One -----"
end

def display_outro(dealer_hand, player_hand, winner)
  puts ""
  puts "------------Results-------------"
  puts "Winner: #{winner}"
  puts "Dealer Hand Value: #{get_hand_value(dealer_hand)}"
  puts "Player Hand Value: #{get_hand_value(player_hand)}"
  puts "---------------------------------"
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
  (1..STARTING_CARDS).each do |_|
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
  prompt "#{player} has: #{player_string}"
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

def compare_hands(hand1, hand2)
  hand1_value = get_hand_value(hand1)
  hand2_value = get_hand_value(hand2)

  if hand2_value > 21
    1
  elsif hand1_value > 21
    0
  elsif hand1_value > hand2_value
    1
  else
    -1
  end
end

def display_game_state(dealer_hand, player_hand)
  prompt "Dealer has: #{dealer_hand[0][0]} and unknown card"
  prompt reveal_hand(player_hand, "Player")
end

def display_results(dealer_hand, player_hand)
  reveal_hand(dealer_hand, "Dealer")
  reveal_hand(player_hand, "Player")
  winner = compare_hands(dealer_hand, player_hand) > 0 ? "DEALER" : "PLAYER"
  display_outro(dealer_hand, player_hand, winner)
end

# main game
clear_screen
display_intro

dealer_hand = []
player_hand = []

deck = initialize_deck RANKS, SUITS
initialize_hand!(player_hand, deck)
initialize_hand!(dealer_hand, deck)

display_game_state(dealer_hand, player_hand)

# player's turn
while !bust?(player_hand)
  if prompt_player == 'hit'
    hit!(player_hand, deck)
    display_game_state(dealer_hand, player_hand)
  else
    break
  end
end

if bust?(player_hand)
  display_results(dealer_hand, player_hand)
  exit 0
end

# dealer's turn
while !bust?(dealer_hand) && (get_hand_value(dealer_hand) <= DEALER_LIMIT)
  prompt "(Dealer says hit me!)"
  hit!(dealer_hand, deck)
  reveal_hand(dealer_hand, "Dealer")
end

if bust?(dealer_hand)
  display_results(dealer_hand, player_hand)
  exit 0
end

display_results(dealer_hand, player_hand)
