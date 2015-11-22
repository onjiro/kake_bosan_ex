defmodule KakeBosanEx.TransactionView do
  use KakeBosanEx.Web, :view

  alias KakeBosanEx.TransactionView
  alias KakeBosanEx.EntryView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{id: transaction.id,
      date: transaction.date,
      description: transaction.description,
      entries: render_many(transaction.entries, EntryView, "entry.json") }
  end
end
