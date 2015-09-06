defmodule KakeBosanEx.TransactionView do
  use KakeBosanEx.Web, :view

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{id: transaction.id}
  end
end
