defmodule BankWeb.Token do
  alias BankWeb.Endpoint
  alias Phoenix.Token

  @sign_salt "bank_api"

  def sign(user) do
    Token.sign(Endpoint, @sign_salt, %{user_id: user.id})
  end

  def verify(token), do: Token.verify(Endpoint, @sign_salt, token)
end
