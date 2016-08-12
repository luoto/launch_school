require 'pry'

RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'].freeze
SUITS = ['Hearts', 'Spades', 'Diamonds', 'Clubs'].freeze

def prompt(msg)
  puts ">#{msg}"
end

def reveal_hand(hand)
  p hand
end

def prompt_player
  answer = nil

  loop do
    puts "Hit or Hold?"
    answer = gets.chomp.downcase
    if answer == 'hit' || answer == 'hold'
      break
    else
      puts 'Please enter hit or hold.'
    end
  end

  answer
end

def display_game_state(dealer_hand, player_hand)
  puts "Dealer has: #{dealer_hand[0][0]} and unknown card"
  puts "Player has: #{player_hand[0][0]} and #{player_hand[1][0]}"
end

def initialize_deck(ranks, suits)
  deck = {}
  ranks.each do |rank|
    if deck[rank].nil?
      deck[rank] = []
    end
    suits.each do |suit|
      deck[rank].push suit
    end
  end
  deck
end

def deal_card!(deck)
  random_key = deck.to_a.sample[0]
  # binding.pry
  suit_index = deck[random_key].sample
  deck[random_key].delete suit_index
  [random_key, suit_index]
end

def hit!(hand, deck)
  hand.push deal_card! deck
end

def get_hand_value(hand)
  value = 0
  hand.each do |card|
    if card[0] == 'King' || card[0] == 'Queen' || card[0] == 'Jack'
      value += 10
    elsif card[0] != 'Ace'
      value += card[0]
    else
      if value + 11 > 21
        value += 1
      else
        value += 11
      end    
    end
  end
  value
end

def bust? hand
  get_hand_value(hand) > 21
end

def initialize_hand! hand, deck
  (1..2).each do |_|
    hit! hand, deck
  end
end

def compare_hands(hand1, hand2)
  hand1_value = get_hand_value hand1
  hand2_value = get_hand_value hand2

  if hand1_value > hand2_value
    1
  elsif hand1_value == hand2_value
    0
  else
    -1
  end
end

def play_twentyone
  dealer_hand = []
  player_hand = []

  deck = initialize_deck RANKS, SUITS

  initialize_hand! player_hand, deck
  initialize_hand! dealer_hand, deck

  while !bust?(player_hand)
    if prompt_player == 'hit'
      hit! player_hand, deck
      p player_hand
    else
      break
    end
  end

  if !bust?(player_hand)
    puts "Dealer won!"
    reveal_hand dealer_hand
  else
    while !bust?(dealer_hand)
      break if (get_hand_value dealer_hand) >= 17
    end
  end

end


play_twentyone
