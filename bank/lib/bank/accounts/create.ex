defmodule Bank.Accounts.Create do
  alias Bank.Repo
  alias Bank.Accounts.Account
  alias Bank.Users

  def call(%{"user_id" => user_id} = params) do
    with {:ok, _user} <- Users.get(user_id) do
      params
      |> Account.changeset()
      |> Repo.insert()
    end
  end
end
