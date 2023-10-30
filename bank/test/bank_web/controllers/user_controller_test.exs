defmodule BankWeb.UserControllerWeb do
  use BankWeb.ConnCase
  import Mox
  alias(Bank.Users)
  alias Users.User

  setup do
    params = %{
      "name" => "Bosa",
      "cep" => "22061030",
      "email" => "bosa@email.com",
      "password" => "123456"
    }

    body = %{
      "bairro" => "Copacabana",
      "cep" => "22061-030",
      "complemento" => "até 62/63",
      "ddd" => "21",
      "gia" => "",
      "ibge" => "3304557",
      "localidade" => "Rio de Janeiro",
      "logradouro" => "Avenida Henrique Dodsworth",
      "siafi" => "6001",
      "uf" => "RJ"
    }

    {:ok, %{user_params: params, body: body}}
  end

  describe "create/2" do
    test "successfully creates an user", %{conn: conn, body: body, user_params: params} do
      expect(Bank.ViaCep.ClientMock, :call, fn _cep ->
        {:ok, body}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      assert %{
               "data" => %{"cep" => "22061030", "email" => "bosa@email.com", "id" => _id, "name" => "Bosa"},
               "message" => "User created"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        name: nil,
        cep: "12",
        email: "bosa@email.com",
        password: "1"
      }

      expect(Bank.ViaCep.ClientMock, :call, fn _cep ->
        {:ok, ""}
      end)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:unprocessable_entity)

      expected = %{
        "errors" => %{
          "cep" => ["should be 8 character(s)"],
          "name" => ["can't be blank"],
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert response == expected
    end
  end

  describe "delete/2" do
    test "successfully deletes an user", %{conn: conn, body: body, user_params: params} do
      expect(Bank.ViaCep.ClientMock, :call, fn _cep ->
        {:ok, body}
      end)

      {:ok, %User{id: id}} = Users.create(params)

      conn
      |> delete(~p"/api/users/#{id}")
      |> get(~p"/api/users/#{id}")
      |> json_response(:not_found)
    end
  end
end
