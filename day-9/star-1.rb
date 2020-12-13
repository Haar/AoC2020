def is_product_of_pairs(list, index, lookback_length)
  start_position = index - lookback_length
  return true if start_position < 0

  list.slice(start_position, index).
    combination(2).
    map(&:sum).
    include?(list[index])
end

def find_first_non_xmas(inputs, preamble)
  pointer = preamble

  inputs.find.with_index do |character, index|
    !is_product_of_pairs(inputs, index, preamble)
  end
end

# input = [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576, ]

# puts find_first_non_xmas(input, 5)

input = File.readlines("./input.txt").map(&:strip).map(&:to_i)

puts find_first_non_xmas(input, 25)
