# FizzBuzz

This is a simple Elixir project that reads a list of numbers from a file, applies the FizzBuzz logic to them, and returns the converted list.

## Usage

To run the FizzBuzz program, you can use the `FizzBuzz.run/1` function. It takes a single argument, which is the filename containing the list of numbers you want to process.

```elixir
FizzBuzz.run("numbers.txt")
```

The function will return a tuple with either `{:ok, result}` containing the converted list or `{:error, reason}` if there was an issue reading the file.

## FizzBuzz Logic

The FizzBuzz logic is applied to each number in the list. Here are the rules:

- If a number is divisible by 3, it's replaced with `:Fizz`.
- If a number is divisible by 5, it's replaced with `:Buzz`.
- If a number is divisible by both 3 and 5, it's replaced with `:FizzBuzz`.

## Testing

This project includes unit tests to ensure its correctness. You can run the tests using ExUnit:

```elixir
mix test
```

The tests cover two scenarios: 

1. When a valid file is provided, it should return the converted list.
2. When an invalid file is provided, it should return an error.

## Example

Suppose you have a file named `numbers.txt` containing the following numbers:

```
1,2,3,4,5,15,20,30
```

Running `FizzBuzz.run("numbers.txt")` will return:

```elixir
{:ok, [1, 2, :Fizz, 4, :Buzz, :FizzBuzz, :Buzz, :FizzBuzz]}
```
