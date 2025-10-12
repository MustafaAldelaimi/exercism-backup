defmodule RPNCalculator.Exception do
  defexception [:message]

  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"
    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "stack underflow occurred, context: " <> value}
      end
    end
  end

  def divide([first, second]) when first == 0 or second == 0, do: raise DivisionByZeroError
  def divide([first, second]), do: div(second, first)
  def divide(_), do: raise(StackUnderflowError, "when dividing") 
end


