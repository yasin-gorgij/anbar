defmodule AnbarWeb.InventoryControllerTest do
  use AnbarWeb.ConnCase

  import Anbar.InventoriesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all inventories", %{conn: conn} do
      conn = get(conn, Routes.inventory_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Inventories"
    end
  end

  describe "new inventory" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.inventory_path(conn, :new))
      assert html_response(conn, 200) =~ "New Inventory"
    end
  end

  describe "create inventory" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.inventory_path(conn, :create), inventory: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.inventory_path(conn, :show, id)

      conn = get(conn, Routes.inventory_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Inventory"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.inventory_path(conn, :create), inventory: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Inventory"
    end
  end

  describe "edit inventory" do
    setup [:create_inventory]

    test "renders form for editing chosen inventory", %{conn: conn, inventory: inventory} do
      conn = get(conn, Routes.inventory_path(conn, :edit, inventory))
      assert html_response(conn, 200) =~ "Edit Inventory"
    end
  end

  describe "update inventory" do
    setup [:create_inventory]

    test "redirects when data is valid", %{conn: conn, inventory: inventory} do
      conn = put(conn, Routes.inventory_path(conn, :update, inventory), inventory: @update_attrs)
      assert redirected_to(conn) == Routes.inventory_path(conn, :show, inventory)

      conn = get(conn, Routes.inventory_path(conn, :show, inventory))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, inventory: inventory} do
      conn = put(conn, Routes.inventory_path(conn, :update, inventory), inventory: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Inventory"
    end
  end

  describe "delete inventory" do
    setup [:create_inventory]

    test "deletes chosen inventory", %{conn: conn, inventory: inventory} do
      conn = delete(conn, Routes.inventory_path(conn, :delete, inventory))
      assert redirected_to(conn) == Routes.inventory_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.inventory_path(conn, :show, inventory))
      end
    end
  end

  defp create_inventory(_) do
    inventory = inventory_fixture()
    %{inventory: inventory}
  end
end
