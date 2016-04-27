require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  (/\d/.match num.to_s) && (/^\d*\.?\d*$/.match num.to_s)
end

def operation_to_message(op)
  case op.to_i
  when 1
    'Adding'
  when 2
    'Subtracting'
  when 3
    'Multiplying'
  when 4
    'Dividing'
  end
end

prompt MESSAGES['welcome']

name = nil

loop do
  name = gets.chomp
  break unless name.empty?
  prompt MESSAGES['valid_name']
end

prompt "Hello #{name}."

loop do
  number1 = nil
  number2 = nil

  loop do
    prompt MESSAGES['first_number']
    number1 = gets.chomp

    break if valid_number? number1
    prompt MESSAGES['valid_number']
  end

  loop do
    prompt MESSAGES['second_number']
    number2 = gets.chomp

    break if valid_number? number2
    prompt MESSAGES['valid_number']
  end

  operator_prompt = <<-MSG
    What option would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt operator_prompt

  operator = nil

  loop do
    operator = gets.chomp.to_i
    break if %w(1 2 3 4).include? operator.to_s
    prompt MESSAGES['options']
  end

  prompt "#{operation_to_message operator} the two numbers..."

  result = case operator
           when 1
             number1 + number2
           when 2
             number1 - number2
           when 3
             number1 * number2
           when 4
             number1.to_f / number2.to_f
           end

  prompt "The result is #{result}"

  prompt MESSAGES['again']
  answer = gets.chomp.downcase
  break unless answer.start_with? 'y'
end

prompt MESSAGES['good_bye']
