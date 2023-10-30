defmodule BankWeb.AccountController do
  use BankWeb, :controller
  alias Bank.Accounts
  alias Accounts.Account

  action_fallback BankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Account{} = account} <- Accounts.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, transaction} <- Accounts.transaction(params) do
      conn
      |> put_status(:ok)
      |> render(:transaction, transaction: transaction)
    end
  end
end
