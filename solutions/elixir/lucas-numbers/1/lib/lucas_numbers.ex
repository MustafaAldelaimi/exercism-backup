defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(count) when not is_integer(count) or count < 1, 
    do: raise(ArgumentError, "count must be specified as an integer >= 1")
  def generate(1), do: [2]
  def generate(2), do: [2, 1]
  def generate(count) do
    count = count - 2
    do_generate(count)
    
  end

  defp do_generate(0 , list), do: Enum.reverse(list)
  defp do_generate(count, list \\ [1, 2]) do 
     [last, snd_last | _rest] = list
     list = [snd_last + last | list]
     do_generate(count - 1, list)
  end
end
