defmodule Bank.Accounts.Transaction do
  alias Bank.Accounts
  alias Accounts.Account
  alias Bank.Repo
  alias Ecto.Multi

  def call(%{"from_account_id" => from_account_id, "to_account_id" => to_account_id, "value" => value}) do
    with %Account{} = from_account <- Repo.get(Account, from_account_id),
         %Account{} = to_account <- Repo.get(Account, to_account_id),
         {:ok, value} <- Decimal.cast(value) do
      Multi.new()
      |> withdraw(from_account, value)
      |> deposit(to_account, value)
      |> Repo.transaction()
      |> handle_transaction()
    else
      nil -> {:error, :not_found}
      :error -> {:error, "Invalid value"}
    end
  end

  def call(_), do: {:error, "Invalid params"}

  defp withdraw(multi, account, value) do
    new_balance = Decimal.sub(account.balance, value)
    changeset = Account.changeset(account, %{balance: new_balance})
    Multi.update(multi, :withdraw, changeset)
  end

  defp deposit(multi, account, value) do
    new_balance = Decimal.add(account.balance, value)
    changeset = Account.changeset(account, %{balance: new_balance})
    Multi.update(multi, :deposit, changeset)
  end

  defp handle_transaction({:ok, _result} = result), do: result
  defp handle_transaction({:error, _op, reason, _}), do: {:error, reason}
end
