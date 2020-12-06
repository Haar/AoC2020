input = File.read("./input.txt").split("\n")

pairs = input.combination(2).to_a

pair = pairs.filter { |pair| pair.map(&:to_i).sum == 2020 }.first

puts pair.inject(1) { |acc, pair| acc * pair.to_i }
