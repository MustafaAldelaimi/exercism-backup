defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      outcome = operation.(stack)
      {:ok, outcome}
    rescue
      _e -> :error
    end  
  end

  def calculate_verbose(stack, operation) do
    try do
      outcome = operation.(stack)
      {:ok, outcome}
    rescue
      e -> {:error, Exception.message(e)}
    end  
  end
end
