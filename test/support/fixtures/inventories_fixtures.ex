defmodule Anbar.InventoriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Anbar.Inventories` context.
  """

  @doc """
  Generate a inventory.
  """
  def inventory_fixture(attrs \\ %{}) do
    {:ok, inventory} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Anbar.Inventories.create_inventory()

    inventory
  end

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        name: "some name",
        quantity: 120.5
      })
      |> Anbar.Inventories.create_item()

    item
  end
end
