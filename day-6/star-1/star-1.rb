class GroupAnswers
  def initialize(buffer)
    @common_answers = buffer.map(&:strip).join("").split("").uniq
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
