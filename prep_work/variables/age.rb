puts "How old are you?"
age = gets.chomp.to_i

(1..4).each do |i|
  puts "In #{i * 10} years you will be:"
  puts age + i * 10
end