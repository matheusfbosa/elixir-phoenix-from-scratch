defmodule FizzBuzzTest do
  use ExUnit.Case

  describe "run/1" do
    test "when a valid file is provided, returns the converted list" do
      expected = {:ok, [1, 2, :Fizz, 4, :Buzz, :Buzz, :FizzBuzz, :Buzz]}

      assert FizzBuzz.run("numbers.txt") == expected
    end

    test "when an invalid file is provided, returns an error" do
      expected = {:error, "Error reading the file: enoent"}

      assert FizzBuzz.run("invalid.txt") == expected
    end
  end
end
