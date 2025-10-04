defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, distance_driven_in_meters: 0, battery_percentage: 100]

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(remote_car) when is_struct(remote_car, RemoteControlCar) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(remote_car) when is_struct(remote_car, RemoteControlCar) do
    battery_percentage = 
      case remote_car.battery_percentage do
        0 -> 
          "empty"
        battery_percentage -> 
          "at #{battery_percentage}%"
      end
    "Battery #{battery_percentage}"
  end

  def drive(remote_car) when is_struct(remote_car, RemoteControlCar) and remote_car.battery_percentage == 0 do
    remote_car
  end
  def drive(remote_car) when is_struct(remote_car, RemoteControlCar) do
    %RemoteControlCar{battery_percentage: battery_percentage, distance_driven_in_meters: distance_driven_in_meters} = remote_car
    %{remote_car | battery_percentage: battery_percentage - 1, distance_driven_in_meters: distance_driven_in_meters + 20}
  end
end
