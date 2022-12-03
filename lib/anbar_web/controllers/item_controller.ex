defmodule AnbarWeb.ItemController do
  use AnbarWeb, :controller

  alias Anbar.Inventories
  alias Anbar.Inventories.Item

  def new(conn, %{"inventory_id" => inventory_id}) do
    changeset = Inventories.change_item(%Item{})

    render(conn, "new.html", changeset: changeset, inventory_id: inventory_id)
  end

  def create(conn, %{"inventory_id" => inventory_id, "item" => item_params}) do
    item_params = Map.put(item_params, "inventory_id", inventory_id)

    case Inventories.create_item(item_params) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: Routes.inventory_path(conn, :show, inventory_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"inventory_id" => inventory_id, "id" => id}) do
    user_id = conn.assigns.current_user.id
    inventory_id = String.to_integer(inventory_id)
    id = String.to_integer(id)
    item = Inventories.get_item!(user_id, inventory_id, id)
    changeset = Inventories.change_item(item)

    render(conn, "edit.html", changeset: changeset, inventory_id: inventory_id, item_id: id)
  end

  def update(conn, %{"inventory_id" => inventory_id, "id" => id, "item" => item_params}) do
    user_id = conn.assigns.current_user.id
    inventory_id = String.to_integer(inventory_id)
    id = String.to_integer(id)
    item = Inventories.get_item!(user_id, inventory_id, id)

    case Inventories.update_item(item, item_params) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: Routes.inventory_path(conn, :show, inventory_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"inventory_id" => inventory_id, "id" => item_id}) do
    user_id = conn.assigns.current_user.id
    inventory_id = String.to_integer(inventory_id)
    item_id = String.to_integer(item_id)
    item = Inventories.get_item!(user_id, inventory_id, item_id)

    {:ok, _item} = Inventories.delete_item(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: Routes.inventory_path(conn, :show, inventory_id))
  end
end
