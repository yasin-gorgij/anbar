defmodule Anbar.Repo.Migrations.AddUsersAssociationToInventories do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :inventory_id, references(:inventories)
    end
  end
end
