SUITS = ['H', 'D', 'S', 'C'].freeze
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].freeze
MAX_VALUE = 21
DEALER_HOLD_POSITION = 17

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    sum += if value == "A"
             11
           elsif value.to_i.zero? # J, Q, K
             10
           else
             value.to_i
           end
  end

  # correct for Aces
  values.select { |value| value == "A" }.count.times do
    sum -= 10 if sum > MAX_VALUE
  end

  sum
end

def busted?(cards)
  total(cards) > MAX_VALUE
end

# :tie, :dealer, :player, :dealer_busted, :player_busted
def detect_result(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > MAX_VALUE
    :player_busted
  elsif dealer_total > MAX_VALUE
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_result(dealer_cards, player_cards)
  result = detect_result(dealer_cards, player_cards)

  case result
  when :player_busted
    prompt "You busted! Dealer wins!"
  when :dealer_busted
    prompt "Dealer busted! You win!"
  when :player
    prompt "You win!"
  when :dealer
    prompt "Dealer wins!"
  when :tie
    prompt "It's a tie!"
  end

  result
end

def play_again?
  puts "-------------"
  prompt "Do you want to play again? (y or n)"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def display_grand_results(dealer_cards, player_cards)
  puts "=============="
  prompt "Dealer has #{dealer_cards}, for a total of: #{total(dealer_cards)}"
  prompt "Player has #{player_cards}, for a total of: #{total(player_cards)}"
  puts "=============="
end

loop do
  prompt "Welcome to First to Five Twenty-One!"
  dealer_wins = 0
  player_wins = 0

  loop do
    puts "=============="
    puts "Dealer Wins: #{dealer_wins}"
    puts "Player Wins: #{player_wins}"
    puts "=============="

    # initialize vars
    deck = initialize_deck
    player_cards = []
    dealer_cards = []

    # initial deal
    2.times do
      player_cards << deck.pop
      dealer_cards << deck.pop
    end

    prompt "Dealer has #{dealer_cards[0]} and ?"
    prompt "You have: #{player_cards[0]} and #{player_cards[1]}, for a total of #{total(player_cards)}."

    # player turn
    loop do
      player_turn = nil
      loop do
        prompt "Would you like to (h)it or (s)tay?"
        player_turn = gets.chomp.downcase
        break if ['h', 's'].include?(player_turn)
        prompt "Sorry, must enter 'h' or 's'."
      end

      if player_turn == 'h'
        player_cards << deck.pop
        prompt "You chose to hit!"
        prompt "Your cards are now: #{player_cards}"
        prompt "Your total is now: #{total(player_cards)}"
      end

      break if player_turn == 's' || busted?(player_cards)
    end

    if busted?(player_cards)
      display_grand_results(dealer_cards, player_cards)
      display_result(dealer_cards, player_cards)
      dealer_wins += 1
      dealer_wins == 5 ? break : next
    else
      prompt "You stayed at #{total(player_cards)}"
    end

    # dealer turn
    prompt "Dealer turn..."

    loop do
      break if busted?(dealer_cards) || total(dealer_cards) >= DEALER_HOLD_POSITION

      prompt "Dealer hits!"
      dealer_cards << deck.pop
      prompt "Dealer's cards are now: #{dealer_cards}"
    end

    dealer_total = total(dealer_cards)
    if busted?(dealer_cards)
      prompt "Dealer total is now: #{dealer_total}"
      display_grand_results(dealer_cards, player_cards)
      display_result(dealer_cards, player_cards)
      player_wins += 1
      player_wins == 5 ? break : next
    else
      prompt "Dealer stays at #{dealer_total}"
    end

    # both player and dealer stays - compare cards!
    display_grand_results(dealer_cards, player_cards)
    winner = display_result(dealer_cards, player_cards)

    if winner == :player
      player_wins += 1
    elsif winner == :dealer
      dealer_wins += 1
    end

    break if (dealer_wins == 5) || (player_wins == 5)
  end

  if player_wins == 5
    puts "PLAYER WINS THE TOURNAMENT"
  else
    puts "DEALER WINS THE TOURNAMENT"
  end

  break unless play_again?
end

prompt "Thank you for playing Twenty-One! Good bye!"
