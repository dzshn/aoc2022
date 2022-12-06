defmodule Aoc do
  def run(msg, i \\ 0) do
    chars = Enum.take(msg, 4) |> MapSet.new |> MapSet.size
    if chars == 4 do
      i + 4
    else
      run(Enum.drop(msg, 1), i + 1)
    end
  end
end

IO.gets("") |> String.to_charlist |> Aoc.run |> IO.puts

