defmodule DNA do
  @nucleic_acid_encode %{
    ?\s => 0b0000,
    ?A => 0b0001,
    ?C => 0b0010,
    ?G => 0b0100,
    ?T => 0b1000
  }
  @nucleic_acid_decode %{
    0b0000 => ?\s,
    0b0001 => ?A,
    0b0010 => ?C,
    0b0100 => ?G,
    0b1000 => ?T
  }
  def encode_nucleotide(code_point) do
    Map.get(@nucleic_acid_encode, code_point)
  end

  def decode_nucleotide(encoded_code) do
    Map.get(@nucleic_acid_decode, encoded_code)
  end

  def encode(dna) do
    #Enum.reduce(dna, <<>>, fn nucleic_acid, bitstring 
    #  -> << bitstring::bitstring, encode_nucleotide(nucleic_acid)::4 >>
    #end)
    do_encode(dna, <<>>)
  end

  defp do_encode(~c"", bitstring), do: bitstring
  defp do_encode(dna, bitstring) do
    [current_nucleic_acid | rest_dna] = dna
    current_nucleic_acid_bits = Map.get(@nucleic_acid_encode, current_nucleic_acid)
    bitstring = << bitstring::bitstring, current_nucleic_acid_bits::4 >>
    do_encode(rest_dna, bitstring)
  end

  def decode(dna) do
    do_decode(dna, [])
  end

  defp do_decode(<<>>, charlist), do: Enum.reverse(charlist)
  defp do_decode(dna, charlist) do
    << head::4, tail::bitstring >> = dna
    head_char = Map.get(@nucleic_acid_decode, head)
    do_decode(tail, [head_char | charlist])
  end
end
