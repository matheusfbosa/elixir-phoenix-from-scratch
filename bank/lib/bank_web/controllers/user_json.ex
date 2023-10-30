defmodule BankWeb.UserJSON do
  alias Bank.Users.User

  def create(%{user: user}), do: %{message: "User created", data: data(user)}
  def login(%{token: token}), do: %{message: "User authenticated with success", bearer: token}
  def get(%{user: user}), do: %{data: data(user)}
  def update(%{user: user}), do: %{message: "User updated", data: data(user)}

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      cep: user.cep,
      email: user.email
    }
  end
end
