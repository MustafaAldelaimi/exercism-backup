defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)
  
  def decode_secret_message_part({function, _, [{:when, _, [{secret_code, _, args} | _]}, _]} = ast, acc) 
    when function == :def or function == :defp, 
      do: do_decode_secret_message_part(ast, acc, secret_code, args)
      
  def decode_secret_message_part({function, _, [{secret_code, _, args}, _]} = ast, acc) 
    when function == :def or function == :defp, 
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
    all_functions =
      string
      |> to_ast()
      |> extract_functions()
    
    Enum.reduce(all_functions, [], fn current_function_ast, code_accum ->
      {_ast, acc} = decode_secret_message_part(current_function_ast, code_accum)
      acc
    end)
    |> Enum.reverse()
    |> Enum.join()
  end

  defp extract_functions({:defmodule, _, [_, [do: module_content]]}) do
    extract_functions(module_content)
  end

  defp extract_functions({:__block__, _, expressions_list}) do
    Enum.flat_map(expressions_list, &extract_functions/1)
  end

  defp extract_functions({:def, _, _} = function_ast), do: [function_ast]
  defp extract_functions({:defp, _, _} = function_ast), do: [function_ast]

  defp extract_functions(_other_ast), do: []
end
