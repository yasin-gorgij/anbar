defmodule Anbar.Repo.Migrations.CreateInventories do
  use Ecto.Migration

  def change do
    create table(:inventories) do
      add :name, :string, null: false
      add :user_id, references(:users), null: false
      add :item_id, references(:items)

      timestamps()
    end

    create index(:inventories, [:item_id])
    create index(:inventories, [:user_id])
    create index(:inventories, [:item_id, :user_id])
  end
end
