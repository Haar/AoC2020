puts File.read("./input.txt").
  split("\n").
  combination(3).
  find { |pair| pair.map(&:to_i).sum == 2020 }.
  inject(1) { |acc, pair| acc * pair.to_i }
