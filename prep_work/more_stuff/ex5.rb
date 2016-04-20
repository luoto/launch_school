def execute(block)
  block.call
end

execute { puts "Hello from inside the execute method!" }

# This gives us and error because we did not pass any agruments to the method. The method is taking a standard argument, but we are trying to pass a block to it.