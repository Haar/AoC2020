defmodule PasswordAttempt do
  defstruct [:min, :max, :char, :attempt]

  @input_regex ~r/(?<min>\d+)-(?<max>\d+)\s+(?<char>\w{1}):\s+(?<attempt>\w+)\n*/

  def parse!(input) do
    captured =
      @input_regex
      |> Regex.named_captures(input)
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)

    struct(PasswordAttempt, captured)
  end

  def valid?(%{min: min, max: max, char: char, attempt: attempt}) do
    char_count =
      attempt
      |> to_charlist()
      |> Enum.filter(&(&1 == to_charlist(char) |> List.first() ))
      |> Enum.count()

    Range.new(String.to_integer(min), String.to_integer(max)) |> Enum.member?(char_count)
  end
end

"./input.txt"
|> File.stream!()
|> Stream.map(&PasswordAttempt.parse!/1)
|> Stream.filter(&PasswordAttempt.valid?/1)
|> Enum.count()
|> IO.inspect()
