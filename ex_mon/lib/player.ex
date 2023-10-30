defmodule ExMon.Player do
  @max_life 100
  @required_keys [:name, :moves, :life]

  @enforce_keys @required_keys
  defstruct @required_keys

  def build(name, move_avg, move_rnd, move_heal) do
    %ExMon.Player{
      name: name,
      moves: %{
        move_avg: move_avg,
        move_rnd: move_rnd,
        move_heal: move_heal
      },
      life: @max_life
    }
  end
end
