defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    do_extract_from_path(data, String.split(path, "."))
  end

  defp do_extract_from_path(data, []), do: data
  defp do_extract_from_path(nil, _), do: nil
  defp do_extract_from_path(data, [path_head | path_tail] = _path_list) do
    do_extract_from_path(data[path_head], path_tail)
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
