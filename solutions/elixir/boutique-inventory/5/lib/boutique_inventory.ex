defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price), :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn item -> item.price == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item -> 
        new_name = String.replace(item.name, old_word, new_word)
        %{item | name: new_name}
      end)
  end

  def increase_quantity(item, count) do
    updated_quantity = Map.new(item.quantity_by_size, fn {size, quantity} -> {size, quantity + count} end)
    %{item | quantity_by_size: updated_quantity}
  end

  def total_quantity(item) do
    Map.get(item, :quantity_by_size)
    |> Enum.reduce(0, fn {_size, quantity}, acc -> quantity + acc end)
  end
end
