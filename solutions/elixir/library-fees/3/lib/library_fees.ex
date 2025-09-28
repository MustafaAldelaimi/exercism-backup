defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, datetime} = NaiveDateTime.from_iso8601(string)
    datetime
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    checkout_date = NaiveDateTime.to_date(checkout_datetime)
    if before_noon?(checkout_datetime) do
      Date.shift(checkout_date, day: 28)
    else
      Date.shift(checkout_date, day: 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)
    date_difference = Date.diff(actual_return_date, planned_return_date)
    if date_difference <= 0 do
      0
    else
      date_difference
    end
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    return_datetime = datetime_from_string(return)
    
    days_late =
      checkout
      |> datetime_from_string()
      |> return_date()
      |> days_late(return_datetime)

    late_fee = days_late * rate
      
    if monday?(return_datetime) do
      late_fee * 0.5
      |> floor()
    else
      late_fee
    end
  end
end
