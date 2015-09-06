defmodule KakeBosanEx.TransactionControllerTest do
  use KakeBosanEx.ConnCase

  alias KakeBosanEx.Transaction
  @valid_attrs %{date: %{day: 17, month: 4, year: 2010}, description: "some content", user_id: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, transaction_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    transaction = Repo.insert %Transaction{}
    conn = get conn, transaction_path(conn, :show, transaction)
    assert json_response(conn, 200)["data"] == %{
      "id" => transaction.id
    }
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, transaction_path(conn, :create), transaction: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Transaction, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, transaction_path(conn, :create), transaction: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    transaction = Repo.insert %Transaction{}
    conn = put conn, transaction_path(conn, :update, transaction), transaction: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Transaction, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    transaction = Repo.insert %Transaction{}
    conn = put conn, transaction_path(conn, :update, transaction), transaction: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    transaction = Repo.insert %Transaction{}
    conn = delete conn, transaction_path(conn, :delete, transaction)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Transaction, transaction.id)
  end
end
