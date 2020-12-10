class Rule
  RULE_REGEX = %{(?<bag>.+ .+) bags contain (?<contents>.*)}

  attr_reader :bag, :contents

  def initialize(input)
    captured = input.match(RULE_REGEX)

    @bag = captured[:bag]

    @contents =
      captured[:contents].
        split(",").
        map { |bag| bag.gsub(/\d/, '').gsub(/bags*/, '').gsub('.', '').strip }
  end
end

def find_parents(bag, rules)
  parent_rules = rules.filter { |rule| rule.contents.include? bag }

  parent_rules.map(&:bag) + parent_rules.map { |rule| find_parents(rule.bag, rules) }.flatten.uniq
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
  reject { |line| line =~ /no other bags/ }.
  map { |line| Rule.new(line) }

puts find_parents("shiny gold", rules).length
