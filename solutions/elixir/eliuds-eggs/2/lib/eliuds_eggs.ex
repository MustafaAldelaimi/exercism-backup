defmodule EliudsEggs do
import Bitwise
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number) when is_integer(number) do
     count_set_bits(number, 0)
  end

  defp count_set_bits(0, count), do: count
  defp count_set_bits(number, count) do
    increment = number &&& 1
    count_set_bits(number >>> 1, count + increment)
  end
end
