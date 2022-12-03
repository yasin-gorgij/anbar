defmodule AnbarWeb.InventoryController do
  use AnbarWeb, :controller

  alias Anbar.Inventories
  alias Anbar.Inventories.Inventory

  def index(conn, _params, user_id) do
    inventories = Inventories.list_inventories(user_id)

    render(conn, "index.html", inventories: inventories)
  end

  def new(conn, _params, _user_id) do
    changeset = Inventories.change_inventory(%Inventory{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"inventory" => inventory_params}, user_id) do
    inventory_params = Map.put(inventory_params, "user_id", user_id)

    case Inventories.create_inventory(inventory_params) do
      {:ok, inventory} ->
        conn
        |> put_flash(:info, "Inventory created successfully.")
        |> redirect(to: Routes.inventory_path(conn, :show, inventory))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, user_id) do
    id = String.to_integer(id)
    inventory = Inventories.get_inventory!(user_id, id)

    items = Inventories.list_inventory_items(user_id, inventory.id)

    render(conn, "show.html", inventory: inventory, items: items)
  end

  def edit(conn, %{"id" => id}, user_id) do
    id = String.to_integer(id)
    inventory = Inventories.get_inventory!(user_id, id)
    changeset = Inventories.change_inventory(inventory)

    render(conn, "edit.html", inventory: inventory, changeset: changeset)
  end

  def update(conn, %{"id" => id, "inventory" => inventory_params}, user_id) do
    id = String.to_integer(id)
    inventory = Inventories.get_inventory!(user_id, id)

    case Inventories.update_inventory(inventory, inventory_params) do
      {:ok, inventory} ->
        conn
        |> put_flash(:info, "Inventory updated successfully.")
        |> redirect(to: Routes.inventory_path(conn, :show, inventory))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", inventory: inventory, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, user_id) do
    id = String.to_integer(id)
    inventory = Inventories.get_inventory!(user_id, id)
    {:ok, _inventory} = Inventories.delete_inventory(inventory)

    conn
    |> put_flash(:info, "Inventory deleted successfully.")
    |> redirect(to: Routes.inventory_path(conn, :index))
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user.id]
    apply(__MODULE__, action_name(conn), args)
  end
end
