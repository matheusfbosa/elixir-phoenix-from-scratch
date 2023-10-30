Mox.defmock(Bank.ViaCep.ClientMock, for: Bank.ViaCep.ClientBehaviour)
Application.put_env(:bank, :via_cep_client, Bank.ViaCep.ClientMock)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Bank.Repo, :manual)
