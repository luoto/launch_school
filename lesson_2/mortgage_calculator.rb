# 34 is for blue
COLOR = 34

# from http://stackoverflow.com/questions/2070010/how-to-output-my-ruby-commandline-text-in-different-colours
def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def prompt(message)
  formatted_message = "> #{message}"
  puts colorize(formatted_message, COLOR)
end

def display_welcome
  puts colorize '-------------------------------------', COLOR.to_s
  puts colorize 'Welcome to the Mortgage Calculator', COLOR.to_s
  puts colorize '-------------------------------------', COLOR.to_s
end

def get_monthly_payment(amount, monthly_interest_rate, months)
  amount * (monthly_interest_rate * (1 + monthly_interest_rate)**months) /
    ((1 + monthly_interest_rate)**months - 1)
end

# ref: https://pdxwolfy.wordpress.com/2016/04/12/numeric-validation-in-ruby/
def numeric?(num)
  Float(num)
rescue ArgumentError
  nil
end

def valid_amount?(amount)
  (numeric? amount) && amount.to_f > 0 && !amount.empty?
end

def valid_interest_rate?(interest_rate)
  (numeric? interest_rate) && interest_rate.to_f > 0 && !interest_rate.empty?
end

def valid_loan_duration?(years)
  (numeric? years) && years.to_f > 0 && !years.empty?
end

def valid_response?(str)
  str = str.downcase
  valid_responses = %w(y n yes no)
  valid_responses.include? str
end

def clear_screen
  system('clear') || system('cls')
end

loop do
  display_welcome

  prompt 'What is the loan amount?'
  amount = nil
  loop do
    amount = gets.chomp
    break if valid_amount? amount
    prompt 'Must enter a positive number.'
  end

  prompt 'What is the monthly interest rate?'
  prompt '(Ex. 5 for 5% or 2.5 for 2.5%)'
  interest_rate = nil
  loop do
    interest_rate = gets.chomp
    break if valid_interest_rate? interest_rate
    prompt 'Must enter a postive number.'
  end

  prompt 'What is the loan duration (in years?)'
  years = nil
  loop do
    years = gets.chomp
    break if valid_loan_duration? years
    prompt 'Enter a valid number.'
  end

  amount = amount.to_f
  annual_interest_rate = interest_rate.to_f / 100
  monthly_interest_rate = annual_interest_rate / 12
  months = years.to_f * 12

  monthly_payment = get_monthly_payment amount, monthly_interest_rate, months
  prompt "Your monthly payemnt is $#{format('%02.2f', monthly_payment)}"

  prompt 'Would you like to try another calculation? (y to calculate again)'
  again = nil
  loop do
    again = gets.chomp
    break if valid_response? again
    prompt 'Please enter either y or n.'
  end
  break unless again.downcase.start_with? 'y'
  clear_screen
end

prompt 'Thank you for using the Mortgage Calculator. Good bye!'
