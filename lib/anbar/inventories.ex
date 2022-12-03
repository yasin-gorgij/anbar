defmodule Anbar.Inventories do
  @moduledoc """
  The Inventories context.
  """

  import Ecto.Query, warn: false
  alias Anbar.Repo

  alias Anbar.Inventories.{Inventory, Item}
  alias Anbar.Accounts

  @doc """
  Returns the list of inventories.

  ## Examples

      iex> list_inventories()
      [%Inventory{}, ...]

  """
  def list_inventories(user_id) do
    user_id
    |> Accounts.get_user!()
    |> Repo.preload([:inventories])
    |> Map.get(:inventories)
  end

  @doc """
  Gets a single inventory.

  Raises `Ecto.NoResultsError` if the Inventory does not exist.

  ## Examples

      iex> get_inventory!(123)
      %Inventory{}

      iex> get_inventory!(456)
      ** (Ecto.NoResultsError)

  """
  def get_inventory!(user_id, inventory_id) do
    user_id
    |> Accounts.get_user!()
    |> Repo.preload([:inventories])
    |> Map.get(:inventories)
    |> Enum.filter(&(&1.id == inventory_id))
    |> List.first()
  end

  @doc """
  Creates a inventory.

  ## Examples

      iex> create_inventory(%{field: value})
      {:ok, %Inventory{}}

      iex> create_inventory(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_inventory(attrs \\ %{}) do
    %Inventory{}
    |> Inventory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a inventory.

  ## Examples

      iex> update_inventory(inventory, %{field: new_value})
      {:ok, %Inventory{}}

      iex> update_inventory(inventory, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_inventory(%Inventory{} = inventory, attrs) do
    inventory
    |> Inventory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a inventory.

  ## Examples

      iex> delete_inventory(inventory)
      {:ok, %Inventory{}}

      iex> delete_inventory(inventory)
      {:error, %Ecto.Changeset{}}

  """
  def delete_inventory(%Inventory{} = inventory) do
    Repo.delete(inventory)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking inventory changes.

  ## Examples

      iex> change_inventory(inventory)
      %Ecto.Changeset{data: %Inventory{}}

  """
  def change_inventory(%Inventory{} = inventory, attrs \\ %{}) do
    Inventory.changeset(inventory, attrs)
  end

  @doc """
  Returns the list of inventory items.

  ## Examples

      iex> list_inventory_items()
      [%Item{}, ...]

  """
  def list_inventory_items(user_id, inventory_id) do
    user_id
    |> get_inventory!(inventory_id)
    |> Repo.preload([:items])
    |> Map.get(:items)
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(user_id, inventory_id, item_id) do
    user_id
    |> get_inventory!(inventory_id)
    |> Repo.preload([:items])
    |> Map.get(:items)
    |> Enum.filter(&(&1.id == item_id))
    |> List.first()
  end

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{field: value})
      {:ok, %Item{}}

      iex> create_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs \\ %{}) do
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a item.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a item.

  ## Examples

      iex> delete_item(item)
      {:ok, %Item{}}

      iex> delete_item(item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking item changes.

  ## Examples

      iex> change_item(item)
      %Ecto.Changeset{data: %Item{}}

  """
  def change_item(%Item{} = item, attrs \\ %{}) do
    Item.changeset(item, attrs)
  end
end
