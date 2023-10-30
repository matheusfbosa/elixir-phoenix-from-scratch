defmodule BankWeb.GreetingController do
  use BankWeb, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> json(%{message: "Hello!"})
  end
end
