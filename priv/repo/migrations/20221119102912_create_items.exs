defmodule Anbar.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string, null: false
      add :quantity, :integer, null: false
      add :inventory_id, references(:items), null: false

      timestamps()
    end
  end
end
