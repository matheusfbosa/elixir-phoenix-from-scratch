# ExMon

**ExMon** is a turn-based game implemented in Elixir. In this game, you take on the role of a player and face off against a computer opponent. The game consists of taking turns, making moves, and attacking or healing to defeat the opponent.

## Usage

To run the application, start it in an interactive Elixir shell (iex) by running the following command:

```sh
iex -S mix
```

### Starting a New Game

To start a new game, create a player and then initiate the game using the `create_player/4` and `start_game/1` functions. For example:

```elixir
ExMon.create_player("Matheus", :punch, :kick, :heal) |> ExMon.start_game()
```

This code creates a player named "Matheus" with the moves `:punch`, `:kick`, and `:heal`, and starts the game.

### Making Moves

Once the game is in progress, you can make moves using the `make_move/1` function. For example:

```elixir
ExMon.make_move(:punch)
```

This code makes a move, such as `:punch`, in the game. The game logic will handle the move and determine the outcome.

## Gameplay

The game involves two players: the player you create and the computer-controlled opponent, known as "Robotinik." Players take turns making moves, either attacking or healing, to reduce their opponent's life points to zero. The game continues until one of the players wins by defeating the other or until you decide to end the game.

## Testing

This project includes unit tests to ensure its functionality. You can run the tests using ExUnit:

```sh
mix test
```

The tests cover various aspects of the game, such as creating a player, starting a game, making moves, and checking game status.

## Dependencies

This project uses the Credo library for code analysis and linting. It's included in the development and test environment. You can install the dependencies using the following command:

```sh
mix deps.get
```
