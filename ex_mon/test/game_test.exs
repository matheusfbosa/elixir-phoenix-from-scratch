defmodule ExMon.GameTest do
  use ExUnit.Case
  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Matheus", :kick, :punch, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Matheus", :kick, :punch, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      Game.start(computer, player)

      expected = %{
        status: :started,
        player: %Player{
          name: "Matheus",
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          life: 100
        },
        computer: %Player{
          name: "Robotinik",
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          life: 100
        },
        turn: :player
      }

      assert expected == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Matheus", :kick, :punch, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      Game.start(computer, player)

      initial_state = %{
        status: :started,
        player: %Player{
          name: "Matheus",
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          life: 100
        },
        computer: %Player{
          name: "Robotinik",
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          life: 100
        },
        turn: :player
      }

      assert initial_state == Game.info()

      new_state = %{
        status: :started,
        player: %Player{
          name: "Matheus",
          moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
          life: 100
        },
        computer: %Player{
          name: "Robotinik",
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          life: 100
        },
        turn: :player
      }

      Game.update(new_state)

      expected = %{new_state | turn: :computer, status: :continue}

      assert expected == Game.info()
    end
  end

  describe "fetch_player/1" do
    test "returns player information" do
      player = Player.build("Matheus", :kick, :punch, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      Game.start(computer, player)

      expected_player = %Player{
        name: "Matheus",
        moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch},
        life: 100
      }

      assert expected_player == Game.fetch_player(:player)
    end
  end

  describe "turn/0" do
    test "returns the current turn" do
      player = Player.build("Matheus", :kick, :punch, :heal)
      computer = Player.build("Robotinik", :punch, :kick, :heal)

      Game.start(computer, player)

      assert :player == Game.turn()
    end
  end
end
