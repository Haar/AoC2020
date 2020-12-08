class GroupAnswers
  def initialize(buffer)
    buffer = buffer.map(&:strip).map { |a| a.split("") }

    @all_answers = buffer.flatten.uniq

    @common_answers =
      buffer.reduce(@all_answers) do |so_far, element|
        so_far.intersection(element)
      end
  end

  def score
    @common_answers.length
  end
end

buffer = []
group_answers = []

File.readlines("./input.txt").each do |line|
  if line == "\n"
    group_answers << GroupAnswers.new(buffer)

    buffer = []
  else
    buffer << line
  end
end

puts group_answers.sum(&:score)
