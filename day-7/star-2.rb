class Rule
  RULE_REGEX = %{(?<bag>.+ .+) bags contain (?<contents>.*)}

  attr_reader :bag, :contents

  def initialize(input)
    captured = input.match(RULE_REGEX)

    @bag = captured[:bag]

    @contents =
      if input =~ /no other bags/
        []
      else
        captured[:contents].
          split(",").
          map { |bag| bag.gsub(/bags*/, '').gsub('.', '').strip }
      end
  end
end

def count_children_bags(bag, rules)
  child_rule = rules.find { |rule| rule.bag == bag }

  if child_rule.contents.empty?
    1
  else
    child_rule.contents.map do |content|
      count = content.match(/\d+/)[0].to_i
      bag = content.gsub(/\d+/, '').strip

      count * count_children_bags(bag, rules)
    end.flatten.sum + 1
  end
end

# input = [
#   "light red bags contain 1 bright white bag, 2 muted yellow bags.",
#   "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
#   "bright white bags contain 1 shiny gold bag.",
#   "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
#   "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
#   "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
#   "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
#   "faded blue bags contain no other bags.",
#   "dotted black bags contain no other bags.",
# ]

rules =
  File.readlines("./input.txt").
  map(&:strip).
  map { |line| Rule.new(line) }

puts count_children_bags("shiny gold", rules) - 1
