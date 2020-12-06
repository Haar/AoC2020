defmodule PasswordAttempt do
  use Bitwise

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
    attempt_list = String.codepoints(attempt)

    at_one =
      attempt_list
      |> Enum.at(String.to_integer(min) - 1)
      |> compare(char)
      |> to_integer()

    at_two =
      attempt_list
      |> Enum.at(String.to_integer(max) - 1)
      |> compare(char)
      |> to_integer()

    (at_one ^^^ at_two) == 1
  end

  defp compare(input, char), do: input == char
  defp to_integer(boolean), do: if boolean, do: 1, else: 0
end

"./input.txt"
|> File.stream!()
|> Stream.map(&PasswordAttempt.parse!/1)
|> Stream.filter(&PasswordAttempt.valid?/1)
|> Enum.count()
|> IO.inspect()


# attempt1 = PasswordAttempt.parse!("1-3 a: abcde")
#
# PasswordAttempt.valid?(attempt1) |> IO.inspect()
#
# attempt2 = PasswordAttempt.parse!("1-3 b: cdefg")
#
# PasswordAttempt.valid?(attempt2) |> IO.inspect()
