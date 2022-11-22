defmodule Anbar.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, collate: :nocase, null: false
      add :hashed_password, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:username])

    create table(:users_tokens) do
      add :user_id, references(:users), null: false
      add :token, :binary, null: false, size: 32
      add :context, :string, null: false

      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
