def find_combinations_that_total(list, target)
  max_index = list.index(target)

  searchable_space = list.slice(0, max_index)

  combination_size = 2

  winning_combo = nil

  while !winning_combo do
    raise Exception.new("WTF Dude!") if combination_size > max_index

    (0..max_index - combination_size).each do |index|
      combination =
        searchable_space[index...(index + combination_size)]

      if combination.sum == target
        winning_combo = combination
      end
    end

    combination_size += 1
  end

  winning_combo
end

# input = [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576, ]

# puts find_combinations_that_total(input, 127).sort.values_at(0, -1).sum

input = File.readlines("./input.txt").map(&:strip).map(&:to_i)

puts find_combinations_that_total(input, 542529149).sort.values_at(0, -1).sum
