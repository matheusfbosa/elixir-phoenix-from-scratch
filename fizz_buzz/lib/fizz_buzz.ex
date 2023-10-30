defmodule FizzBuzz do
  def run(filename) do
    filename
    |> File.read()
    |> handle_file_read()
  end

  defp handle_file_read({:ok, result}) do
    result =
      result
      |> String.split(",")
      |> Enum.map(&handle_number/1)

    {:ok, result}
  end

  defp handle_file_read({:error, reason}), do: {:error, "Error reading the file: #{reason}"}

  defp handle_number(number) do
    number
    |> String.to_integer()
    |> eval()
  end

  defp eval(number) when rem(number, 3) == 0 and rem(number, 5) == 0, do: :FizzBuzz
  defp eval(number) when rem(number, 3) == 0, do: :Fizz
  defp eval(number) when rem(number, 5) == 0, do: :Buzz
  defp eval(number), do: number
end
