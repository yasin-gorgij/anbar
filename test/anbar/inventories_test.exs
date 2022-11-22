defmodule Anbar.InventoriesTest do
  use Anbar.DataCase

  alias Anbar.Inventories

  describe "inventories" do
    alias Anbar.Inventories.Inventory

    import Anbar.InventoriesFixtures

    @invalid_attrs %{name: nil}

    test "list_inventories/0 returns all inventories" do
      inventory = inventory_fixture()
      assert Inventories.list_inventories() == [inventory]
    end

    test "get_inventory!/1 returns the inventory with given id" do
      inventory = inventory_fixture()
      assert Inventories.get_inventory!(inventory.id) == inventory
    end

    test "create_inventory/1 with valid data creates a inventory" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Inventory{} = inventory} = Inventories.create_inventory(valid_attrs)
      assert inventory.name == "some name"
    end

    test "create_inventory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventories.create_inventory(@invalid_attrs)
    end

    test "update_inventory/2 with valid data updates the inventory" do
      inventory = inventory_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Inventory{} = inventory} =
               Inventories.update_inventory(inventory, update_attrs)

      assert inventory.name == "some updated name"
    end

    test "update_inventory/2 with invalid data returns error changeset" do
      inventory = inventory_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventories.update_inventory(inventory, @invalid_attrs)
      assert inventory == Inventories.get_inventory!(inventory.id)
    end

    test "delete_inventory/1 deletes the inventory" do
      inventory = inventory_fixture()
      assert {:ok, %Inventory{}} = Inventories.delete_inventory(inventory)
      assert_raise Ecto.NoResultsError, fn -> Inventories.get_inventory!(inventory.id) end
    end

    test "change_inventory/1 returns a inventory changeset" do
      inventory = inventory_fixture()
      assert %Ecto.Changeset{} = Inventories.change_inventory(inventory)
    end
  end

  describe "items" do
    alias Anbar.Inventories.Item

    import Anbar.InventoriesFixtures

    @invalid_attrs %{name: nil, quantity: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Inventories.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Inventories.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{name: "some name", quantity: 120.5}

      assert {:ok, %Item{} = item} = Inventories.create_item(valid_attrs)
      assert item.name == "some name"
      assert item.quantity == 120.5
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventories.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{name: "some updated name", quantity: 456.7}

      assert {:ok, %Item{} = item} = Inventories.update_item(item, update_attrs)
      assert item.name == "some updated name"
      assert item.quantity == 456.7
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventories.update_item(item, @invalid_attrs)
      assert item == Inventories.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Inventories.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Inventories.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Inventories.change_item(item)
    end
  end
end
