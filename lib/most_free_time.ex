defmodule MostFreeTime do
  require Integer
  @moduledoc """
  Documentation for `MostFreeTime`.
  """

  @doc """
  Most Free Time.

  ## Examples

      iex> MostFreeTime.most_free_time(["12:15PM-02:00PM", "09:00AM-10:00AM", "10:30AM-12:00PM"])
      "00:30"

  """

  def most_free_time( attrs \\ ["12:15PM-02:00PM", "09:00AM-10:00AM", "10:30AM-12:00PM"]) do
    #attrs = ["12:15PM-02:00PM", "09:00AM-10:00AM", "10:30AM-12:00PM"]
    #attrs = ["12:15PM-02:00PM", "09:00AM-12:11PM", "02:02PM-04:00PM"]

    array_datetimes_sort = attrs
    |> Enum.map(fn hours ->
      length = String.length(hours)
      init_hour = hours |> String.slice(0..4)
      init_hour_type = hours |> String.slice(5..6)
      #{:ok, init_datetime, 0} = DateTime.from_iso8601("2022-04-22T#{init_hour}:00Z")
      end_hour = hours |> String.slice((length-7)..(length-3))
      end_hour_type = hours |> String.slice((length-2)..length)

      init_hour = if init_hour_type == "PM" do
        change_hour_pm_to_all(hours |> String.slice(0..1)) <> ":" <> (hours |> String.slice(3..4))
      else
        hours |> String.slice(0..4)
      end

      end_hour = if end_hour_type == "PM" do
          change_hour_pm_to_all(hours |> String.slice((length-7)..(length-6))) <> (hours |> String.slice((length-5)..(length-3)))
      else
        hours |> String.slice((length-7)..(length-3))
      end

      {:ok, init_datetime, 0} = DateTime.from_iso8601("2022-04-22T#{init_hour}:00Z")
      {:ok, end_datetime, 0} = DateTime.from_iso8601("2022-04-22T#{end_hour}:00Z")
      [
        init_datetime,
        end_datetime
      ]
    end)
    |> Enum.concat()
    |> Enum.sort()

    time_free_second = array_datetimes_sort
    |> Enum.with_index()
    |> Enum.map(fn({date_hour, index}) ->
      if index > 0 && Integer.is_odd(index) do
        if length(array_datetimes_sort) > (index + 1) do
          date_one = array_datetimes_sort |> Enum.at(index)
          date_two = array_datetimes_sort |> Enum.at(index + 1)
          DateTime.diff(date_two, date_one)
        else
          0
        end
      else
        0
      end
    end)
    |> Enum.max()

    hours = change_formt(div time_free_second, 3600)
    minutes = change_formt(div time_free_second, 60)

    "#{hours}:#{minutes}"
  end

  def change_hour_pm_to_all(hour) do
    case hour do
      "12" -> "12"
      "01" -> "13"
      "02" -> "14"
      "03" -> "15"
      "04" -> "16"
      "05" -> "17"
      "06" -> "18"
      "07" -> "19"
      "08" -> "20"
      "09" -> "21"
      "10" -> "22"
      "11" -> "23"
      _ -> "00"
    end
  end

  def change_formt(number) do
    if number >= 10 do
      "#{number}"
    else
      "0#{number}"
    end
  end
end
