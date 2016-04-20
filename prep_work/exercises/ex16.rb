a = ['white snow', 'winter wonderland', 'melting ice', 'slippery sidewalk', 'salted roads', 'white trees']

a_new = a.map { |words| words.split }.flatten
p a_new