defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)
  
  def decode_secret_message_part({function, _, [{:when, _, [{secret_code, _, args} | _]}, _]} = ast, acc) 
    when function in [:def, :defp], 
      do: do_decode_secret_message_part(ast, acc, secret_code, args)
      
  def decode_secret_message_part({function, _, [{secret_code, _, args}, _]} = ast, acc) 
    when function in [:def, :defp], 
      do: do_decode_secret_message_part(ast, acc, secret_code, args)

  def decode_secret_message_part(ast, acc), do: {ast, acc}
  
  defp do_decode_secret_message_part(ast, acc, secret_code, args) do
      secret_code =
        secret_code
        |> Atom.to_string()
        |> String.slice(0, length(args || []))
        
      {ast, [secret_code | acc]}
  end

  def decode_secret_message(string) do
    string
      |> to_ast()
      |> Macro.prewalk([], &decode_secret_message_part/2)
      |> then(&elem(&1, 1))
      |> Enum.reverse()
      |> Enum.join()
  end
end
