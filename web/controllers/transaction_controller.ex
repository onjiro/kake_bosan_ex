defmodule KakeBosanEx.TransactionController do
  use KakeBosanEx.Web, :controller

  alias KakeBosanEx.Transaction

  plug :scrub_params, "transaction" when action in [:create, :update]

  def index(conn, params) do
    transactions = case params do
                     %{ "dateFrom" => _, "dateTo" => ""} ->
                       Repo.all(
                         from t in Transaction,
                         where: t.user_id == ^user_id(conn),
                         where: t.date >= ^params["dateFrom"],
                         order_by: [desc: t.date],
                         preload: [entries: :item])
                     %{ "dateFrom" => _, "dateTo" => _} ->
                       Repo.all(
                         from t in Transaction,
                         where: t.user_id == ^user_id(conn),
                         where: t.date >= ^params["dateFrom"],
                         where: t.date <= ^params["dateTo"],
                         order_by: [desc: t.date],
                         preload: [entries: :item])
                     _ ->
                       Repo.all(
                         from t in Transaction,
                         where: t.user_id == ^user_id(conn),
                         order_by: [desc: t.date],
                         preload: [entries: :item])
                   end
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    params = transaction_params
    |> Dict.put("user_id", user_id(conn))
    |> Dict.put("entries", Enum.map(transaction_params["entries"], fn {_, one} -> Dict.put(one, "user_id", user_id(conn)) end))
    changeset = Transaction.changeset(%Transaction{}, params)

    case changeset.valid? && Repo.insert(changeset) do
      {:ok, transaction} ->
        render(conn, "show.json", transaction: Repo.one(
              from t in Transaction,
              where: t.id == ^transaction.id,
              preload: [entries: :item]
        ))
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

  def user_id(conn) do
    get_session(conn, :current_user).id
  end
end
