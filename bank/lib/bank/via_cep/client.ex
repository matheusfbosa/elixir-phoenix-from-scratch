defmodule Bank.ViaCep.Client do
  use Tesla
  alias Bank.ViaCep.ClientBehaviour

  @default_base_url "https://viacep.com.br/ws"
  plug Tesla.Middleware.JSON

  @behaviour Bank.ViaCep.ClientBehaviour

  @impl ClientBehaviour
  def call(base_url \\ @default_base_url, cep) do
    "#{base_url}/#{cep}/json"
    |> get()
    |> handle_response()
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: %{"erro" => true}}}), do: {:error, :not_found}
  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}), do: {:ok, body}
  defp handle_response({:ok, %Tesla.Env{status: 400}}), do: {:error, :bad_request}
  defp handle_response({:error, _}), do: {:error, :internal_server_error}
end
