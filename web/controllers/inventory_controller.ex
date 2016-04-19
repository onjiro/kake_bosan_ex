defmodule KakeBosanEx.InventoryController do
  use KakeBosanEx.Web, :controller

  alias KakeBosanEx.Inventory
  alias KakeBosanEx.Item

  plug :scrub_params, "inventory" when action in [:create, :update]

  # 最新の棚卸額を返す
  def index(conn, %{"current" => "true"}) do
    # todo Item の種類を限定してクエリをかける
    # todo inventory.calculate を実装する
    inventories = from(item in Item, where: item.user_id == ^user_id(conn))
    |> Inventory.calculate
    render(conn, "index.json", inventories: inventories)
  end

  def index(conn, _params) do
    inventories = Repo.all(Inventory)
    render(conn, "index.json", inventories: inventories)
  end

  def create(conn, %{"inventory" => inventory_params}) do
    changeset = Inventory.changeset(%Inventory{}, inventory_params)

    case Repo.insert(changeset) do
      {:ok, inventory} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", inventory_path(conn, :show, inventory))
        |> render("show.json", inventory: inventory)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KakeBosanEx.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    inventory = Repo.get!(Inventory, id)
    render(conn, "show.json", inventory: inventory)
  end

  def update(conn, %{"id" => id, "inventory" => inventory_params}) do
    inventory = Repo.get!(Inventory, id)
    changeset = Inventory.changeset(inventory, inventory_params)

    case Repo.update(changeset) do
      {:ok, inventory} ->
        render(conn, "show.json", inventory: inventory)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KakeBosanEx.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    inventory = Repo.get!(Inventory, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(inventory)

    send_resp(conn, :no_content, "")
  end

  def user_id(conn) do
    get_session(conn, :current_user).id
  end
end
