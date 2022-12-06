defmodule Aoc do
  def run(msg, i \\ 0) do
    chars = Enum.take(msg, 14) |> MapSet.new |> MapSet.size
    if chars == 14 do
      i + 14
    else
      run(Enum.drop(msg, 1), i + 1)
    end
  end
end

IO.gets("") |> String.to_charlist |> Aoc.run |> IO.puts

