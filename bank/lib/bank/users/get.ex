defmodule Bank.Users.Get do
  alias Bank.Repo
  alias Bank.Users.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
