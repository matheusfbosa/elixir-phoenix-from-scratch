defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias ExMon.{Game, Player}

  describe "create_player/4" do
    test "returns a player" do
      expected = %Player{
        name: "Matheus",
        moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
        life: 100
      }

      assert expected == ExMon.create_player("Matheus", :kick, :punch, :heal)
    end
  end

  describe "start_game/1" do
    test "returns a player" do
      player = Player.build("Matheus", :kick, :punch, :heal)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game has started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Matheus", :kick, :punch, :heal)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:kick)
        end)

      assert messages =~ "The Player attacked the computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move: wrong"
    end

    test "when game over, returns a message" do
      messages =
        capture_io(fn ->
          new_state = %{
            status: :game_over,
            player: %Player{
              name: "Matheus",
              moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
              life: 100
            },
            computer: %Player{
              name: "Robotinik",
              moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
              life: 0
            },
            turn: :player
          }

          Game.update(new_state)
          ExMon.make_move(:kick)
        end)

      assert messages =~ "Game over..."
      assert messages =~ "status: :game_over"
    end
  end
end
