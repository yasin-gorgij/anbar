defmodule Anbar.Inventories.Inventory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "inventories" do
    field :name, :string

    has_many :items, Anbar.Inventories.Item, on_delete: :delete_all

    belongs_to :user, Anbar.Accounts.User

    timestamps()
  end

  def changeset(inventory, attrs) do
    inventory
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
    |> validate_name()
    |> assoc_constraint(:user)
  end

  defp validate_name(changeset) do
    changeset
    |> validate_length(:name, min: 1, max: 30, message: "Item name should be between 1 to 30")
    |> validate_format(:name, ~r/^[[:alnum:][:space:]-_]+$/u,
      message: "Inventory name can contain alphanumeric, space, - and _ signs"
    )
  end
end
