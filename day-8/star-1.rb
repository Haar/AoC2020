$state = { accumulator: 0, lines: [] }

# lines =
#   File.readlines("./input.txt").
#   map(&:strip)

$lines =
  [
    "nop +0",
    "acc +1",
    "jmp +4",
    "acc +3",
    "jmp -3",
    "acc -99",
    "acc +1",
    "jmp -4",
    "acc +6",
  ]

def process_command(index)
  puts $state[:accumulator]
  if $state[:lines].include? index
    return nil
  end

  $state[:lines] << index

  command, arg = $lines[index].split(" ")

  arg = arg.gsub('+', '').to_i

  case command
  when "nop" then return index + 1
  when "acc" then $state[:accumulator] += arg; return index + 1
  when "jmp" then return index + arg
  end
end

index = 0

while index != nil do
  index = process_command(index)
end

puts $state
