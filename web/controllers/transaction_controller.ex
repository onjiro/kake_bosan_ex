defmodule KakeBosanEx.TransactionController do
  use KakeBosanEx.Web, :controller

  alias KakeBosanEx.Transaction

  plug :scrub_params, "transaction" when action in [:create, :update]

  def index(conn, _params) do
    transactions = Repo.all(Transaction)
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    user_id = get_session(conn, :current_user_id)
    params = transaction_params
    |> Dict.put("user_id", user_id)
    |> Dict.put("entries", Enum.map(transaction_params["entries"], fn {_, one} -> Dict.put(one, "user_id", user_id) end))
    changeset = Transaction.changeset(%Transaction{}, params)

    case changeset.valid? && Repo.insert(changeset) do
      {:ok, transaction} ->
        render(conn, "show.json", transaction: transaction)
      _ ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(KakeBosanEx.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Repo.get(Transaction, id)
    render conn, "show.json", transaction: transaction
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Repo.get(Transaction, id)
    changeset = Transaction.changeset(transaction, transaction_params)

    if changeset.valid? do
      transaction = Repo.update(changeset)
      render(conn, "show.json", transaction: transaction)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(KakeBosanEx.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Repo.get(Transaction, id)

    transaction = Repo.delete(transaction)
    render(conn, "show.json", transaction: transaction)
  end
end
