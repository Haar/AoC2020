defmodule Toboggan do
	@tree "#"

  def traverse(terrain, x, y) do
		traverse(terrain, x, y, terrain |> Enum.at(0) |> Enum.count(), Enum.count(terrain), 0, 0, 0)
  end

	defp traverse(_terrain, _d_x, d_y, _width, length, _x, y, tree_count) when y + d_y >= length, do: tree_count

	defp traverse(terrain, d_x, d_y, width, length, x, y, tree_count) do
		new_y = d_y + y
		new_x = Integer.mod(d_x + x, width)

		landing_char =
			terrain
			|> Enum.at(new_y)
			|> Enum.at(new_x)

		new_tree_count = if landing_char == @tree, do: tree_count + 1, else: tree_count

		traverse(terrain, d_x, d_y, width, length, new_x, new_y, new_tree_count)
	end
end

# testcase =
#   [ String.codepoints("..##......."),
# 		String.codepoints("#...#...#.."),
# 		String.codepoints(".#....#..#."),
# 		String.codepoints("..#.#...#.#"),
# 		String.codepoints(".#...##..#."),
# 		String.codepoints("..#.##....."),
# 		String.codepoints(".#.#.#....#"),
# 		String.codepoints(".#........#"),
# 		String.codepoints("#.##...#..."),
# 		String.codepoints("#...##....#"),
# 		String.codepoints(".#..#...#.#") ]
#
# (Toboggan.traverse(testcase, 3, 1) == 7) |> IO.inspect()

"./input.txt"
|> File.stream!()
|> Stream.map(&String.trim/1)
|> Enum.map(&String.codepoints/1)
|> Toboggan.traverse(3, 1)
|> IO.inspect()
