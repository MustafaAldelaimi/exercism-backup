defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort(inventory, fn item, next_item -> item.price <= next_item.price end)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn item -> item.price == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item -> 
        Map.update!(item, :name, fn existing_value -> String.replace(item.name, old_word, new_word) end)
      end)
  end

  def increase_quantity(item, count) do
      Map.update!(item, :quantity_by_size, fn sizes -> 
        Enum.map(sizes, fn {size, quantity} -> {size, quantity + count} end) 
        |> Map.new()
      end)
  end

  def total_quantity(item) do
    Map.get(item, :quantity_by_size)
    |> Enum.reduce(0, fn {_size, quantity}, acc -> quantity + acc end)
  end
end
