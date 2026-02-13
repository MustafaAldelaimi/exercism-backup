defmodule PaintByNumber do
  def palette_bit_size(color_count) when is_integer(color_count) do
    calculate_bit_size(color_count, 0)
  end

  defp calculate_bit_size(color_count, current_bit_size) do
    if 2 ** current_bit_size >= color_count do
      current_bit_size
    else
      calculate_bit_size(color_count, current_bit_size + 1)
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    << 0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    size = palette_bit_size(color_count)
    <<pixel_color_index::size(size), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _color_count), do: nil
  def get_first_pixel(picture, color_count) do
    size = palette_bit_size(color_count) 
    <<head::integer-size(size), _rest::bitstring>> = picture
    head
  end

  def drop_first_pixel(<<>>, _color_count), do: <<>>
  def drop_first_pixel(picture, color_count) do
    size = palette_bit_size(color_count) 
    <<_head::integer-size(size), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(<<>>, <<>>), do: <<>>
  def concat_pictures(picture1, <<>>), do: picture1
  def concat_pictures(<<>>, picture2), do: picture2
  def concat_pictures(picture1, picture2) do
    << picture1::bitstring, picture2::bitstring >>
  end
end
