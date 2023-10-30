defmodule Bank.Users.Create do
  alias Bank.Repo
  alias Bank.Users.User
  alias Bank.ViaCep.Client, as: ViaCepClient

  def call(%{"cep" => cep} = params) do
    with {:ok, _result} <- client().call(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp client() do
    Application.get_env(:bank, :via_cep_client, ViaCepClient)
  end
end
