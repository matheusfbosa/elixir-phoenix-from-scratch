defmodule Bank.Users do
  alias Bank.Users.{Create, Get, Update, Delete, Login}

  defdelegate create(params), to: Create, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate update(params), to: Update, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate login(params), to: Login, as: :call
end
