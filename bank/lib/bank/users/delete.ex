defmodule Bank.Users.Delete do
  alias Bank.Repo
  alias Bank.Users.User

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> Repo.delete(user)
    end
  end
end
