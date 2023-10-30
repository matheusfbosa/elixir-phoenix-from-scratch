defmodule Bank.Repo.Migrations.AddUniqueConstraintUserAccountsTable do
  use Ecto.Migration

  def change do
    create unique_index(:accounts, [:user_id], name: :accounts_user_id_unique)
  end
end
