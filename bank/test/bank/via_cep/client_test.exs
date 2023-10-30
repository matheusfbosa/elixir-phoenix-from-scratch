defmodule Bank.ViaCep.ClientTest do
  use ExUnit.Case, async: true
  alias Bank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "successfully returns CEP info", %{bypass: bypass} do
      cep = "22061030"

      body = ~s({
        "bairro": "Copacabana",
        "cep": "22061-030",
        "complemento": "até 62/63",
        "ddd": "21",
        "gia": "",
        "ibge": "3304557",
        "localidade": "Rio de Janeiro",
        "logradouro": "Avenida Henrique Dodsworth",
        "siafi": "6001",
        "uf": "RJ"
      })

      Bypass.expect_once(bypass, "GET", "/22061030/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      expected_response =
        {:ok,
         %{
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
         }}

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
