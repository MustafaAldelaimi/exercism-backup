# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{registrations: opts, next_id: 1} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.registrations end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, 
      fn state -> 
        new_registration = %Plot{plot_id: state.next_id, registered_to: register_to}
        new_registrations = state.registrations ++ [new_registration]
        
        {new_registration, %{state | next_id: state.next_id + 1, registrations: new_registrations}}
      end)
  end

  def release(pid, plot_id) do
    Agent.update(pid,
      fn state ->
        updated_registrations = Enum.reject(state.registrations, fn registration -> registration.plot_id == plot_id end)
        %{state | registrations: updated_registrations}
      end)
  end

  def get_registration(pid, plot_id) do
    pid
    |> list_registrations()
    |> Enum.find(fn registration -> registration.plot_id == plot_id end)
    |> case do
         nil -> {:not_found, "plot is unregistered"}
         registration -> registration
       end
  end
end
