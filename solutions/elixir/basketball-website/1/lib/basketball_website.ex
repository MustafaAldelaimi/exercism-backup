defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    split_path = String.split(path, ".")
    do_extract_from_path(data, split_path)
  end

  defp do_extract_from_path(data, []), do: data
  defp do_extract_from_path(nil, _), do: nil
  defp do_extract_from_path(data, [path_head | path_tail] = _path_list) do
    do_extract_from_path(data[path_head], path_tail)
  end

  def get_in_path(data, path) do
    split_path = String.split(path, ".")
    get_in(data, split_path)
  end
end
