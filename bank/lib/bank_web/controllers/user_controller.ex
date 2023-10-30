defmodule BankWeb.UserController do
  use BankWeb, :controller
  alias BankWeb.Token
  alias Bank.Users
  alias Users.User

  action_fallback BankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end

  def login(conn, params) do
    with {:ok, %User{} = user} <- Users.login(params) do
      token = Token.sign(user)

      conn
      |> put_status(:ok)
      |> render(:login, token: token)
    end
  end

  @spec show(any(), map()) :: {:error, :not_found} | {:ok, any()} | Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Users.get(id) do
      conn
      |> put_status(:ok)
      |> render(:get, user: user)
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Users.update(params) do
      conn
      |> put_status(:ok)
      |> render(:update, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _user} <- Users.delete(id) do
      conn
      |> send_resp(:no_content, "")
    end
  end
end
