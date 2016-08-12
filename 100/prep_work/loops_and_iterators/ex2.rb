puts "Type STOP to stop"

while true
  if gets.chomp == "STOP"
    break
  else
    puts "Again?"
  end
end