def factorial n

  return 0 if n == 0

  result = 1

  (1..n).each do |i|
    result *= i
  end

  result
  
end


puts factorial 5
puts factorial 6
puts factorial 7
puts factorial 8