defmodule Anbar.Inventories.Item do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :quantity, :integer

    belongs_to :inventory, Anbar.Inventories.Inventory

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:name, :quantity, :inventory_id])
    |> validate_required([:name, :quantity, :inventory_id])
    |> validate_name()
    |> validate_quantity()
    |> assoc_constraint(:inventory)
  end

  defp validate_name(changeset) do
    changeset
    |> validate_length(:name, min: 1, max: 80, message: "Item name should be between 1 to 80")
    |> validate_format(:name, ~r/^[[:print:]]+$/u,
      message: "Item name can contain all printing characters"
    )
  end

  defp validate_quantity(changeset) do
    changeset
    |> validate_number(:quantity,
      greater_than_or_equal_to: 0,
      message: "Item quantity should be greater than or equal to 0"
    )
  end
end
