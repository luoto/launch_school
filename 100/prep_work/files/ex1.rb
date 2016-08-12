simple = File.read("simple_file.txt")
original = File.new("original_file.txt", "w+")

File.open(original, "a") do |f|
  f.puts simple
end

File.read(original)