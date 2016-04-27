CYAN = 36

# from http://stackoverflow.com/questions/2070010/how-to-output-my-ruby-commandline-text-in-different-colours
def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def prompt(message)
  formatted_message = "> #{message}"
  puts colorize(formatted_message, CYAN)
end

def display_welcome
  puts colorize '-------------------------------------', CYAN.to_s
  puts colorize 'Welcome to the Mortgage Calculator', CYAN.to_s
  puts colorize '-------------------------------------', CYAN.to_s
end

def get_monthly_payment(amount, monthly_interest_rate, months)
  amount.to_f * (monthly_interest_rate * (1 + monthly_interest_rate)**months.to_i) /
    ((1 + monthly_interest_rate)**months.to_i - 1)
end

# http://stackoverflow.com/questions/1034418/determine-if-a-string-is-a-valid-float-value
def numeric?(num)
  !(/(^(\d+)(\.)?(\d+)?)|(^(\d+)?(\.)(\d+))/ =~ num.to_s).nil?
end

def valid_amount?(amount)
  (numeric? amount) && amount.to_i > 0 && !amount.empty?
end

def valid_interest_rate?(interest_rate)
  (numeric? interest_rate) && interest_rate.to_f > 0 && !interest_rate.empty?
end

def valid_loan_duration?(years)
  (numeric? years) && years.to_i > 0 && !years.empty?
end

loop do
  display_welcome

  amount = nil
  interest_rate = nil
  years = nil

  prompt 'What is the loan amount?'
  loop do
    amount = gets.chomp
    break if valid_amount? amount
    prompt 'Must enter a positive number.'
  end

  prompt 'What is the monthly interest rate?'
  prompt '(Ex. 5 for 5% or 2.5 for 2.5%)'
  loop do
    interest_rate = gets.chomp
    break if valid_interest_rate? interest_rate
    prompt 'Must enter a postive number.'
  end

  prompt 'What is the loan duration (in years?)'
  loop do
    years = gets.chomp
    break if valid_loan_duration? years
    prompt 'Enter a valid number.'
  end

  annual_interest_rate = interest_rate.to_f / 100
  monthly_interest_rate = annual_interest_rate / 12
  months = years.to_i * 12

  monthly_payment = get_monthly_payment amount, monthly_interest_rate, months

  prompt "Your monthly payemnt is $#{format('%02.2f', monthly_payment)}"

  prompt 'Would you like to try another calulation? (Y to calculate again)'
  again = gets.chomp
  break unless again.downcase.start_with?('y')
end

prompt 'Thank you for using the Mortgage Calculator. Good bye!'
