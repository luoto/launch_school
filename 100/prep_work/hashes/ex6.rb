words =  [
  'demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
  'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
  'flow', 'neon'
]

anagram = {}

words.each do |word|
  key = word.split('').sort.join
  if anagram.has_key?(key)
    anagram[key] << word
  else
    anagram[key] = [word]
  end
end

anagram.each do |k, v|
  p v
end