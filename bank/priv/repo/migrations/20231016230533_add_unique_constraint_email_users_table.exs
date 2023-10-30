defmodule Bank.Repo.Migrations.AddUniqueConstraintEmailUsersTable do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:email], name: :users_email_unique)
  end
end
