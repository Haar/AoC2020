def generate_mutations(lines)
  (0...lines.length).inject([]) do |result, index|
    mutation = generate_mutation(lines, index)
    if mutation
      result << mutation
    end

    result
  end
end

def generate_mutation(lines, index)
  if lines[index] =~ /acc/
    return nil
  end
  new_lines = lines.dup

  command, arg = lines[index].split(" ")

  case command
  when 'jmp' then new_lines[index] = "nop #{arg}"
  when 'nop' then new_lines[index ] = "jmp #{arg}"
  end

  new_lines
end

# $lines =
#   [
#     "nop +0",
#     "acc +1",
#     "jmp +4",
#     "acc +3",
#     "jmp -3",
#     "acc -99",
#     "acc +1",
#     "jmp -4",
#     "acc +6",
#   ]

$lines =
  File.readlines("./input.txt").
  map(&:strip)

$mutations = generate_mutations($lines)

class Runner
  attr_reader :accumulator

  def initialize(lines)
    @accumulator = 0
    @lines = []
    @input = lines
    @infinite_loop = false

    index = 0

    while (!@completed && !@infinite_loop)
      if index == @input.length - 1
        @completed = true
      end

      if @lines.include? index
        @infinite_loop = true
      end

      index = process_command(index)
    end
  end

  def resolves?
    !@infinite_loop
  end

  private

  def process_command(index)
    @lines << index

    command, arg = @input[index].split(" ")

    arg = arg.gsub('+', '').to_i

    case command
    when "nop" then return index + 1
    when "acc" then @accumulator += arg; return index + 1
    when "jmp" then return index + arg
    end
  end
end

puts $mutations.map { |lines| Runner.new(lines) }.find(&:resolves?)&.accumulator

