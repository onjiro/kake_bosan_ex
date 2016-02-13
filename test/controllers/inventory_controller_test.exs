defmodule KakeBosanEx.InventoryControllerTest do
  use KakeBosanEx.ConnCase

  alias KakeBosanEx.Inventory
  @valid_attrs %{amount: 42, date: "2010-04-17"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, inventory_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    inventory = Repo.insert! %Inventory{}
    conn = get conn, inventory_path(conn, :show, inventory)
    assert json_response(conn, 200)["data"] == %{"id" => inventory.id,
      "item_id" => inventory.item_id,
      "date" => inventory.date,
      "amount" => inventory.amount}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, inventory_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, inventory_path(conn, :create), inventory: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Inventory, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, inventory_path(conn, :create), inventory: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    inventory = Repo.insert! %Inventory{}
    conn = put conn, inventory_path(conn, :update, inventory), inventory: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Inventory, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    inventory = Repo.insert! %Inventory{}
    conn = put conn, inventory_path(conn, :update, inventory), inventory: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    inventory = Repo.insert! %Inventory{}
    conn = delete conn, inventory_path(conn, :delete, inventory)
    assert response(conn, 204)
    refute Repo.get(Inventory, inventory.id)
  end
end
