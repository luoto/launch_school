def count_down n
  if n <= 0
    puts n
  else
    puts n
    count_down n - 1
  end
end

count_down 10