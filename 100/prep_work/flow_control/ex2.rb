def caps str
  str.length > 10 ? str.upcase : str
end

puts caps "hello"
puts caps "hello world"