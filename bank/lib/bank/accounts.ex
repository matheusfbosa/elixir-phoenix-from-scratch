defmodule Bank.Accounts do
  alias Bank.Accounts.{Create, Transaction}

  defdelegate create(params), to: Create, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
