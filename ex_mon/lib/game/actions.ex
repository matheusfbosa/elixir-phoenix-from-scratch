defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.{Attack, Heal}

  def fetch_move(move) do
    Game.fetch_player(:player)
    |> Map.get(:moves)
    |> find_move(move)
  end

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end

  def heal() do
    case Game.turn() do
      :player -> Heal.heal_life(:player)
      :computer -> Heal.heal_life(:computer)
    end
  end

  defp find_move(moves, move) do
    Enum.find_value(moves, {:error, move}, fn {k, v} ->
      if v == move, do: {:ok, k}
    end)
  end
end
