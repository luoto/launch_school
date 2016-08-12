# merge does not mutate the caller
puts "merge"
h1 = {a: 1, b: 2}
h2 = {c: 3, e: 4}

h3 = h1.merge(h2)
p h1
p h2
p h3


puts "merge!"
# merge! mutates the caller
h4 = {a: 1, b: 2}
h5 = {c: 3, e: 4}

h6 = h4.merge!(h5)
p h4
p h5
p h6