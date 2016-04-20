str = ["laboratory", "experiment", "Pans Labyrinth", "elaborate", "polar bear"]

str.each do |word|
  if /lab/ =~ word
    puts word
  else
    puts "No Match"
  end
end